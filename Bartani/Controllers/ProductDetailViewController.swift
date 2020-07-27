//
//  ProductDetailViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var product: Product?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var barterButton: UIButton!
    @IBOutlet weak var productThumbnailImage: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var sellerDistanceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: VerticalTopAlignLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barterButton.layer.cornerRadius = 6
        
        productTitleLabel.text = product?.title
        productThumbnailImage.image = product?.image
        productQuantityLabel.text = product?.quantity
        
        if let price = product?.price {
            productPriceLabel.text = "Rp \(price)"
        }
        
        searchBar.backgroundImage = UIImage()
        productDescriptionLabel.text = product?.description
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBarter" {
            if let vc = segue.destination as? BarterViewController {
                vc.product = product
            }
        }
    }

}
