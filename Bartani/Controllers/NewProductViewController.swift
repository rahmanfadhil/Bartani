//
//  NewProductViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit
import AVFoundation

struct NewProductData {
    let title: String
    let price: Int
    let quantity: String
    let description: String
    let imageURL: URL
    let harvestedAt: Date
}

class NewProductViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate  {
    @IBOutlet weak var productTitleTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var productQuantityTextField: UITextField!
    @IBOutlet weak var productDescriptionTextField: UITextField!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var harvestedAtTextField: UITextField!
    
    let datePicker = UIDatePicker()
    
    var imageURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.layer.cornerRadius = 6
        
        assignTextFieldDelegates()
        createDatePicker()
    }
    
    // MARK: - Upload image
    
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
    
    // MARK: - Next button tapped
    
    @IBAction func nextTapped(_ sender: Any) {
        if let imageURL = imageURL {
            let product = NewProductData(
                title: productTitleTextField.text!,
                price: Int(productPriceTextField.text!) ?? 0,
                quantity: productQuantityTextField.text!,
                description: productDescriptionTextField.text!,
                imageURL: imageURL,
                harvestedAt: datePicker.date
            )
            
            self.performSegue(withIdentifier: "toLocation", sender: product)
            self.imageURL = nil
            self.productImage.image = UIImage(named: "image-placeholder")
            self.productTitleTextField.text = ""
            self.productPriceTextField.text = ""
            self.productQuantityTextField.text = ""
            self.productDescriptionTextField.text = ""
        } else {
            let alert = UIAlertController(title: "Product must have an image!", message: "You must provide at least one image for a product.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    // MARK: - Setup UI
    
    func assignTextFieldDelegates() {
        productTitleTextField.delegate = self
        productPriceTextField.delegate = self
        productQuantityTextField.delegate = self
        productDescriptionTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func createDatePicker() {
        // Create the toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // Add the done button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        harvestedAtTextField.inputAccessoryView = toolbar
        toolbar.setItems([doneBtn], animated: true)
        
        // assign date picker to the textfield
        harvestedAtTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        harvestedAtTextField.text = "\(formatter.string(from: datePicker.date))"
        self.view.endEditing(true)
    }
    
    // MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SetLocationViewController, let data = sender as? NewProductData {
            vc.productData = data
        }
    }
}
