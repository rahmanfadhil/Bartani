//
//  OfferTableViewCell.swift
//  Bartani
//
//  Created by Rahman Fadhil on 29/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {

    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var thumbnailImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        boxView.layer.cornerRadius = 16
        thumbnailImage.layer.cornerRadius = 16
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
