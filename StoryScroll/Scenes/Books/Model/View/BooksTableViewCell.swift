//
//  BooksTableViewCell.swift
//  StoryScroll
//
//  Created by Adarsh Singh on 30/09/23.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet var bookImage: UIImageView!
    @IBOutlet var genre: UILabel!
    
    @IBOutlet var bookTitle: UILabel!
    
    @IBOutlet var author: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
