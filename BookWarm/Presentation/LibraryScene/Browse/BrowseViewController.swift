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
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: BrowseTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: BrowseTableViewCell.identifier)
        tableView.rowHeight = 150.0
    }
    
    func layoutTableView() {
    }
    

}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  =  tableView.dequeueReusableCell(withIdentifier: BrowseTableViewCell.identifier) as? BrowseTableViewCell else { return UITableViewCell() }
        cell.configureCell(movie: movieList.movie[indexPath.row])
        return cell
    }
    
    
}


