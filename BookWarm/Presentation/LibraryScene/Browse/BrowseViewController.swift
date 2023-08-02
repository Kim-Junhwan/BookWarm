//
//  BrowseViewController.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/08/02.
//

import UIKit

class BrowseViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let movieList = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setCollectionView()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: BrowseTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BrowseTableViewCell.identifier)
        tableView.rowHeight = 150.0
        tableView.tableHeaderView?.frame.size.height = 150.0
    }
    
    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: BrowseCollectionViewCell.identifier, bundle: nibBundle), forCellWithReuseIdentifier: BrowseCollectionViewCell.identifier)
        let flowlayout = UICollectionViewFlowLayout()
        let cellheight = collectionView.frame.height
        let cellWidth = cellheight * 0.7
        flowlayout.itemSize = CGSize(width: cellWidth, height: cellheight)
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        flowlayout.scrollDirection = .horizontal
        flowlayout.minimumInteritemSpacing = 20.0
        collectionView.collectionViewLayout = flowlayout
    }
    
    func presentDetailView(movie: Movie) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else { return }
        vc.movie = movie
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  =  tableView.dequeueReusableCell(withIdentifier: BrowseTableViewCell.identifier) as? BrowseTableViewCell else { return UITableViewCell() }
        cell.configureCell(movie: movieList.movie[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentDetailView(movie: movieList.movie[indexPath.row])
    }
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.movie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowseCollectionViewCell.identifier, for: indexPath) as? BrowseCollectionViewCell else { return UICollectionViewCell() }
        cell.imageView.image = UIImage(named: movieList.movie[indexPath.row].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentDetailView(movie: movieList.movie[indexPath.row])
    }
}
