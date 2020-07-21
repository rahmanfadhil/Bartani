//
//  ProductCollectionViewCell.swift
//  Bartani
//
//  Created by Rahman Fadhil on 20/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let path = UIBezierPath(roundedRect: thumbnailImage.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 7, height: 7))
        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        thumbnailImage.layer.mask = maskLayer
        
        boxView.layer.shadowOffset = .zero
        boxView.layer.shadowOpacity = 0.5
        boxView.layer.shadowRadius = 3
        boxView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        boxView.layer.masksToBounds = false
        boxView.layer.cornerRadius = 7
    }

}
