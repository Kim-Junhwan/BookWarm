//
//  LibraryCollectionViewController.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/07/31.
//

import UIKit

class LibraryCollectionViewController: UICollectionViewController {
    
    enum Metric {
        static let numberOfColumns: Int = 2
        static let inset: CGFloat = 20.0
    }
    
    var movieList = MovieInfo().movie

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: LibraryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: LibraryCollectionViewCell.identifier)
        layoutCollectionView()
    }
    
    func layoutCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = Metric.inset
        flowLayout.minimumInteritemSpacing = Metric.inset
        flowLayout.sectionInset = UIEdgeInsets(top: Metric.inset, left: Metric.inset, bottom: Metric.inset, right: Metric.inset)
        let width = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize(width: (width-(3*Metric.inset))/2, height: 200)
        collectionView.collectionViewLayout = flowLayout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as? LibraryCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(movie: movieList[indexPath.row])
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
        return cell
    }
    
    
    @objc func tapLikeButton(_ sender: UIButton) {
        movieList[sender.tag].isLike.toggle()
        collectionView.reloadData()
        //collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select")
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        vc.movie = movieList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapSearchButton(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchViewController")
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalPresentationStyle = .fullScreen
        nvc.modalTransitionStyle = .coverVertical
        present(nvc, animated: true)
    }
    
}
