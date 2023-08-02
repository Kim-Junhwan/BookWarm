//
//  BrowseCollectionViewCell.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/08/02.
//

import UIKit

class BrowseCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BrowseCollectionViewCell"

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }

}
