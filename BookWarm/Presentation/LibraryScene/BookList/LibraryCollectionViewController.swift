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
    
    @IBOutlet weak var tabBarSearchButton: UIBarButtonItem!
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    var movieList = MovieInfo().movie
    var currentMovieList: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        setSearchBar()
        currentMovieList = movieList
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
        var movie = currentMovieList[sender.tag]
        movie.isLike.toggle()
        if let movieIndex = movieList.firstIndex(where: { $0.title == movie.title }) {
            movieList[movieIndex] = movie
            currentMovieList[sender.tag].isLike.toggle()
        }
        collectionView.reloadData()
    }
    
    @IBAction func tapSearchButton(_ sender: UIBarButtonItem) {
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem?.isHidden.toggle()
        searchBar.becomeFirstResponder()
    }
}

extension LibraryCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMovieList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as? LibraryCollectionViewCell else { return UICollectionViewCell() }
        let cellMovie = currentMovieList[indexPath.row]
        cell.configureCell(movie: cellMovie)
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: Identifier.storyboard, bundle: nil).instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController else { return }
        let cellMovie = currentMovieList[indexPath.row]
        vc.movie = cellMovie
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LibraryCollectionViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem?.isHidden = false
        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentMovieList = movieList.filter({ $0.title.contains(searchText) })
        if searchText == ""{
            currentMovieList = movieList
        }
        collectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            navigationItem.titleView = nil
            navigationItem.rightBarButtonItem?.isHidden = false
            currentMovieList = movieList
        }
        collectionView.reloadData()
    }
}
