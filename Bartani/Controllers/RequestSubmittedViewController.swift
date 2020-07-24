//
//  RequestSubmittedViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class RequestSubmittedViewController: UIViewController {
    
    @IBOutlet weak var okayButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        okayButton.layer.cornerRadius = 6
    }
    
    @IBAction func okayTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}
