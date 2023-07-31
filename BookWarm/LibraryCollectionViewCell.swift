//
//  LibraryCollectionViewCell.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/07/31.
//

import UIKit

class LibraryCollectionViewCell: UICollectionViewCell {
    
    enum Metric {
        static let cornerRadius: CGFloat = 20.0
    }
    
    static let identifier = "LibraryCollectionViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var openDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Metric.cornerRadius
    }
    
    func configureCell(movie: Movie) {
        posterImageView.image = UIImage(named: "\(movie.title)")
        nameLabel.text = movie.title
        openDateLabel.text = movie.releaseDate
        nameLabel.adjustsFontSizeToFitWidth = true
        openDateLabel.adjustsFontSizeToFitWidth = true
    }
    
    

}
