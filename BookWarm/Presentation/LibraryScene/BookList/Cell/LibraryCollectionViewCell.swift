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
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Metric.cornerRadius
    }
    
    func configureCell(book: Book) {
        posterImageView.getImageFromUrl(url: book.imageUrl)
        nameLabel.text = book.title
        priceLabel.text = String(book.price)
        nameLabel.adjustsFontSizeToFitWidth = true
        priceLabel.adjustsFontSizeToFitWidth = true
        let likeButtonImage = book.isLike ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(likeButtonImage, for: .normal)
    }
    
    @IBAction func tapLikeButton(_ sender: UIButton) {
    }
    

}
