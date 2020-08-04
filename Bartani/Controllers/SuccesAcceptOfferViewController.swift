//
//  SuccesAcceptOfferViewController.swift
//  Bartani
//
//  Created by Arif Rahman Sidik on 28/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class SuccesAcceptOfferViewController: UIViewController {
    
    var offer : Offer?
    var product : Product?

    @IBOutlet weak var okayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
