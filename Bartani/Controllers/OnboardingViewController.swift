//
//  OnboardingViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 07/08/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var gettingStarted: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gettingStarted.layer.cornerRadius = 6
        gettingStarted.layer.shadowOffset = .zero
        gettingStarted.layer.shadowOpacity = 0.5
        gettingStarted.layer.shadowRadius = 3
        gettingStarted.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
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
