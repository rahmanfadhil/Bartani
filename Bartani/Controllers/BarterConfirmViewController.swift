//
//  BarterConfirmViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 27/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class BarterConfirmViewController: UIViewController {
    
    var sellerProduct: Product?
    var buyerProduct: Product?

    @IBOutlet weak var proceedButton: UIButton!
    
    // Seller card
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var sellerTitle: UILabel!
    @IBOutlet weak var sellerQuantity: UILabel!
    @IBOutlet weak var sellerPrice: UILabel!
    @IBOutlet weak var sellerBox: UIView!
    
    // Buyer card
    @IBOutlet weak var buyerImage: UIImageView!
    @IBOutlet weak var buyerTitle: UILabel!
    @IBOutlet weak var buyerQuantity: UILabel!
    @IBOutlet weak var buyerPrice: UILabel!
    @IBOutlet weak var buyerBox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        proceedButton.layer.cornerRadius = 6
        
        let path = UIBezierPath(roundedRect: sellerImage.bounds, byRoundingCorners:[.bottomLeft, .topLeft], cornerRadii: CGSize(width: 7, height: 7))
        let sellerMaskLayer = CAShapeLayer()
        sellerMaskLayer.path = path.cgPath
        let buyerMaskLayer = CAShapeLayer()
        buyerMaskLayer.path = path.cgPath
        
        sellerBox.layer.shadowOffset = .zero
        sellerBox.layer.shadowOpacity = 0.5
        sellerBox.layer.shadowRadius = 3
        sellerBox.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        sellerBox.layer.masksToBounds = false
        sellerBox.layer.cornerRadius = 7
        
        buyerBox.layer.shadowOffset = .zero
        buyerBox.layer.shadowOpacity = 0.5
        buyerBox.layer.shadowRadius = 3
        buyerBox.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        buyerBox.layer.masksToBounds = false
        buyerBox.layer.cornerRadius = 7
        
        sellerTitle.text = sellerProduct?.title
        sellerImage.image = sellerProduct?.image
        sellerQuantity.text = sellerProduct?.quantity
        sellerImage.layer.mask = sellerMaskLayer
        
        buyerTitle.text = buyerProduct?.title
        buyerImage.image = buyerProduct?.image
        buyerQuantity.text = buyerProduct?.quantity
        buyerImage.layer.mask = buyerMaskLayer
        
        if let buyerProduct = buyerProduct, let sellerProduct = sellerProduct {
            sellerPrice.text = "Rp \(sellerProduct.price)"
            buyerPrice.text = "Rp \(buyerProduct.price)"
        }
    }
    
    // MARK: - Appear and dissapear
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Proceed tapped
    
    @IBAction func proceedTapped(_ sender: Any) {
        if let buyerProduct = buyerProduct, let sellerProduct = sellerProduct {
            CloudKitHelper.saveOffer(data: CloudKitHelper.InsertOffer(
                buyerName: "John",
                sellerName: "Doe",
                buyerProduct: buyerProduct.ckRecord,
                sellerProduct: sellerProduct.ckRecord
            )) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toSuccess", sender: nil)
                }
            }
        }
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
