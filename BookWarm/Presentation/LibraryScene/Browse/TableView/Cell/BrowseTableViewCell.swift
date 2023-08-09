//
//  BrowseTableViewCell.swift
//  BookWarm
//
//  Created by JunHwan Kim on 2023/08/02.
//

import UIKit

class BrowseTableViewCell: UITableViewCell {
    
    static let identifier = "BrowseTableViewCell"

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(book: Book) {
    }
    
}
