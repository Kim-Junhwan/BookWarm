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
        static let cellHeight: CGFloat = 200.0
    }
    
    enum Identifier {
        static let storyboard: String = "Main"
    }
    
    var movieList = MovieInfo().movie
    @IBOutlet weak var tabBarSearchButton: UIBarButtonItem!
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        setSearchBar()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        layoutCollectionView()
    }
    
    func registerCollectionViewCell() {
        let movieCellNib = UINib(nibName: LibraryCollectionViewCell.identifier, bundle: nil)
        collectionView.register(movieCellNib, forCellWithReuseIdentifier: LibraryCollectionViewCell.identifier)
    }
    
    func layoutCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = Metric.inset
        flowLayout.minimumInteritemSpacing = Metric.inset
        flowLayout.sectionInset = UIEdgeInsets(top: Metric.inset, left: Metric.inset, bottom: Metric.inset, right: Metric.inset)
        let width = view.window?.screen.bounds.width ?? .zero
        flowLayout.itemSize = CGSize(width: (width-(3*Metric.inset))/CGFloat(Metric.numberOfColumns), height: Metric.cellHeight)
        collectionView.collectionViewLayout = flowLayout
    }
    
    func setSearchBar() {
        searchBar.delegate = self
    }
    
    @objc func tapLikeButton(_ sender: UIButton) {
        movieList[sender.tag].isLike.toggle()
        collectionView.reloadItems(at: [IndexPath(row: sender.tag, section: 0)])
    }
    
    @IBAction func tapSearchButton(_ sender: UIBarButtonItem) {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem?.isHidden.toggle()
        searchBar.becomeFirstResponder()
    }
}

extension LibraryCollectionViewController {

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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: Identifier.storyboard, bundle: nil).instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController else { return }
        vc.movie = movieList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LibraryCollectionViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem?.isHidden.toggle()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
