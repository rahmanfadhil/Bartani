//
//  EditProfileViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 10/08/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var profile: Profile?

    @IBOutlet weak var profilePictureImage: UIImageView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var bioText: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var imageURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bioText.layer.cornerRadius = 5
        bioText.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        bioText.layer.borderWidth = 0.5
        bioText.clipsToBounds = true
        
        saveButton.layer.cornerRadius = 6
        
        if let profile = profile {
            nameText.text = profile.name
            phoneText.text = profile.phone
            bioText.text = profile.bio
            profilePictureImage.image = profile.profileImage
        }
    }
    
    @IBAction func save(_ sender: Any) {
        CloudKitHelper.updateProfile(input: CloudKitHelper.ProfileInput(
            name: nameText.text,
            phone: phoneText.text,
            profileImage: imageURL,
            bio: bioText.text
        )) {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func setPhoto(_ sender: Any) {
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
        
        profilePictureImage.image = image
        self.imageURL = imageURL
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
