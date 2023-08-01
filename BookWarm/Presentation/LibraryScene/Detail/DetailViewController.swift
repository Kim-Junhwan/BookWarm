//
//  DetailCollectionViewController.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    var name: String = "" {
        didSet {
            title = name
        }
    }
    
    var movie: Movie = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.title
        posterImageView.image = UIImage(named: movie.title)
        nameLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        runtimeLabel.text = String(movie.runtime)
        rateLabel.text = String(movie.rate)
        overviewLabel.text = movie.overview
    }
    
}
