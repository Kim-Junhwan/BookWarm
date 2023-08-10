//
//  LibraryCollectionViewController.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON

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
    
    var currentPage: Int = 1 {
        didSet {
            nextPage = currentPage + 1
        }
    }
    var nextPage: Int = 1
    var isEnd: Bool = false
    var bookList = [Book]()
    var currentMovieList: [Book] = [] {
        didSet {
        }
    }
    var currentSearchText: String = ""
    var flag: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        setSearchBar()
        currentMovieList = bookList
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        currentMovieList[sender.tag].isLike.toggle()
        var movie = currentMovieList[sender.tag]
        if let movieIndex = bookList.firstIndex(where: { $0.title == movie.title }) {
            bookList[movieIndex] = movie
            
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
        return bookList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LibraryCollectionViewCell.identifier, for: indexPath) as? LibraryCollectionViewCell else { return UICollectionViewCell() }
        let cellMovie = bookList[indexPath.row]
        cell.configureCell(book: cellMovie)
        cell.likeButton.tag = indexPath.item
        cell.likeButton.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: Identifier.storyboard, bundle: nil).instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController else { return }
        let cellMovie = bookList[indexPath.row]
        vc.book = cellMovie
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func getBookList(searchText: String, page: Int) {
        print(#function)
        let url = "https://dapi.kakao.com/v3/search/book"
        let header: HTTPHeaders = ["Content-Type" : "application/json","Authorization":"KakaoAK \(APIkey.kakao)"]
        AF.request(url, parameters: ["query":searchText, "page":page], headers: header).validate().response { response in
            switch response.result {
            case .success(let value):
                if searchText != self.currentSearchText {
                    self.bookList.removeAll()
                    self.isEnd = false
                }
                var currentBookList: [Book] = []
                let json = JSON(value)
                let isEnd = json["meta"]["is_end"].boolValue
                if isEnd {
                    self.isEnd = true
                }
                let fetchBooklist = json["documents"].arrayValue
                for bookInfo in fetchBooklist {
                    let title = bookInfo["title"].stringValue
                    let imageUrl = bookInfo["thumbnail"].stringValue
                    let price = bookInfo["price"].intValue
                    let authors = bookInfo["authors"].arrayValue.map { $0.stringValue }
                    let contents = bookInfo["contents"].stringValue
                    currentBookList.append(Book(title: title, authors: authors, imageUrl: imageUrl, content: contents, price: price, isLike: false))
                }
                self.currentSearchText = searchText
                self.bookList.append(contentsOf: currentBookList)
                self.collectionView.reloadData()
            case .failure(let error):
                    print(error)
            }
            
        }
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
        currentMovieList = bookList.filter({ $0.title.contains(searchText) })
        if searchText == ""{
            currentMovieList = bookList
        }
        collectionView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            bookList.removeAll()
            navigationItem.titleView = nil
            navigationItem.rightBarButtonItem?.isHidden = false
            currentMovieList = bookList
        }
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        getBookList(searchText: searchText, page: currentPage)
    }
}

extension LibraryCollectionViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >=  (scrollView.contentSize.height-(scrollView.frame.height-tabBarController!.tabBar.frame.height)) && !isEnd && !flag{
            flag = true
            getBookList(searchText: searchBar.text!, page: nextPage)
            currentPage += 1
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        flag = false
    }
}
