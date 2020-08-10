//
//  EditProfileViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 10/08/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var bioText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bioText.layer.cornerRadius = 5
        bioText.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        bioText.layer.borderWidth = 0.5
        bioText.clipsToBounds = true
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
