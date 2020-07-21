//
//  BarterViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class BarterViewController: UIViewController {
    
    var product: Product?

    @IBOutlet weak var productBox: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productBox.layer.cornerRadius = 10
        productBox.clipsToBounds = true
        
        productTitleLabel.text = product?.title
        productQuantityLabel.text = product?.quantity
        productImage.image = product?.image
        
        if let price = product?.price {
            productPriceLabel.text = "Rp \(price)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
