//
//  bookTableViewCell.swift
//  BookApp
//
//  Created by Grace on 13/02/2018.
//  Copyright © 2018 Grace. All rights reserved.
//

import UIKit

class bookTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var starView: UIImageView!
    @IBOutlet var bookImage: UIImageView! {
        //making the image round
        didSet{
            bookImage.layer.cornerRadius = bookImage.bounds.width / 2
            bookImage.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
