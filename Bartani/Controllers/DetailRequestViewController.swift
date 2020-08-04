//
//  DetailRequestViewController.swift
//  Bartani
//
//  Created by Arif Rahman Sidik on 27/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class DetailRequestViewController: UIViewController {
    
    var product : Product?

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameProductLabel: UILabel!
    @IBOutlet weak var weightProductLabel: UILabel!
    @IBOutlet weak var priceProductLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        productImageView.image = product?.image
        nameProductLabel.text = product?.title
        weightProductLabel.text = product?.quantity
        
         if let price = product?.price {
            priceProductLabel.text = "Rp \(price)"
        }
    }

    @IBAction func showDeleteOffer(_ sender: UIButton) {
        let alert = UIAlertController(title: "Delete", message: "This offer will be deleted from this app", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Delete Offers", style: .cancel, handler: {(ACTION) in
            
        }))
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
