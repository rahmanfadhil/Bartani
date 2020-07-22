//
//  RequestSubmittedViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class RequestSubmittedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okayTapped(_ sender: Any) {
        tabBarController?.selectedIndex = 0
        navigationController?.popViewController(animated: false)
    }

}
