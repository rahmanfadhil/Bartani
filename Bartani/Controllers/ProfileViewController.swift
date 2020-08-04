//
//  ProfileViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var offers = [Offer]()
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "OfferTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 120
        tableView.separatorStyle = .none

        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2
    }
    
    @IBAction func segmentTapped(_ sender: Any) {
        updateSegment()
    }
    
    func updateSegment() {
        let index = segmentedControl.selectedSegmentIndex
        
        if index == 0 {
            CloudKitHelper.fetchMyOffers { (offers) in
                self.offers = offers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        } else {
            CloudKitHelper.fetchMyRequest { (offers) in
                self.offers = offers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - View did apppear
    
    override func viewDidAppear(_ animated: Bool) {
        updateSegment()
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OfferTableViewCell
        let offer = offers[indexPath.row]
        cell.productTitle.text = offer.buyerProduct.title
        cell.productDescription.text = offer.buyerProduct.description
        cell.thumbnailImage.image = offer.buyerProduct.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if segmentedControl.selectedSegmentIndex == 0{
            print(indexPath.row)
            let offer = offers[indexPath.row]
            performSegue(withIdentifier: "toOfferDetails", sender: offer)
        } else {
            print(indexPath.row)
            let offer = offers[indexPath.row]
            performSegue(withIdentifier: "toRequestDetails", sender: offer)
        }
        
        
        
        //let offer = offers[indexPath.row]
        
        //performSegue(withIdentifier: "toOfferDetails", sender: vc)
//        if indexPath.section == 0 {
//
//        }
//        else if indexPath.section == 1 {
//
//        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MyOfferItemViewController, let offer = sender as? Offer {
            vc.offer = offer
        }
    }
    

}
