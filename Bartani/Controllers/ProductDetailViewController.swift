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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barterButton.layer.cornerRadius = 10
        
        productTitleLabel.text = product?.title
        productThumbnailImage.image = product?.image
        productQuantityLabel.text = product?.quantity
        
        if let price = product?.price {
            productPriceLabel.text = "Rp \(price)"
        }
        
        searchBar.backgroundImage = UIImage()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
