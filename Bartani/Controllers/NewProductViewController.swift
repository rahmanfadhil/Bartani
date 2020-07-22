//
//  NewProductViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class NewProductViewController: UIViewController {
    @IBOutlet weak var productTitleTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var productQuantityTextField: UITextField!
    @IBOutlet weak var productAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        let product = Product(
            title: productTitleTextField.text!,
            price: Int(productPriceTextField.text!) ?? 0,
            quantity: productQuantityTextField.text!,
            address: productAddressTextField.text!,
            image: UIImage(named: "cabai")
        )
        
        CloudKitHelper.saveProduct(data: product) {
            self.performSegue(withIdentifier: "toSuccessPage", sender: self)
        }
    }
}
