//
//  DetailRequestViewController.swift
//  Bartani
//
//  Created by Arif Rahman Sidik on 27/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class DetailRequestViewController: UIViewController, UIAlertViewDelegate {


    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var weightProductLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var offer: Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        productImageView.image = offer?.buyerProduct.image
        nameProductLabel.text = offer?.buyerProduct.title
        weightProductLabel.text = offer?.buyerProduct.quantity
        
        if let price = offer?.buyerProduct.price {
            priceProductLabel.text = "Rp \(price)"
        }
    }

    @IBAction func showDeleteOffer(_ sender: UIButton) {
        if let offer = offer {
            let alert = UIAlertController(title: "Delete", message: "This offer will be deleted from this app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                CloudKitHelper.deleteProduct(offer: offer) {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
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
