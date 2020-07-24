//
//  NewProductViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit
import AVFoundation

class NewProductViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    @IBOutlet weak var productTitleTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var productQuantityTextField: UITextField!
    @IBOutlet weak var productAddressTextField: UITextField!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var confirmButton: UIButton!
    
    var imageURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmButton.layer.cornerRadius = 6
    }
    
    @IBAction func addPhotoTapped(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let imageURL = info[.imageURL] as? URL else { return }

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found!")
            return
        }
        
        productImage.image = image
        self.imageURL = imageURL
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        if let imageURL = imageURL {
            let product = CloudKitHelper.InsertProduct(
                title: productTitleTextField.text!,
                price: Int(productPriceTextField.text!) ?? 0,
                quantity: productQuantityTextField.text!,
                address: productAddressTextField.text!,
                imageURL: imageURL
            )
            
//            CloudKitHelper.saveProduct(data: product) {
//                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toSuccessPage", sender: self)
                    self.imageURL = nil
                    self.productImage.image = UIImage(named: "image-placeholder")
                    self.productTitleTextField.text = ""
                    self.productPriceTextField.text = ""
                    self.productQuantityTextField.text = ""
                    self.productAddressTextField.text = ""
//                }
//            }
        } else {
            let alert = UIAlertController(title: "Product must have an image!", message: "You must provide at least one image for a product.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
}
