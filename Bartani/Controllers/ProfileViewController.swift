//
//  ProfileViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var bioLabel: UILabel!
    
    var offers = [Offer]()
    var profile: Profile?
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        CloudKitHelper.getUserProfile { (profile) in
            if let profile = profile {
                DispatchQueue.main.async {
                    self.profile = profile
                    if let image = profile.profileImage {
                        self.profilePicture.image = image
                    }
                    self.profileName.text = profile.name
                    self.bioLabel.text = profile.bio
                }
            } else {
                DispatchQueue.main.async {
                    self.profileName.text = "Unknown"
                }
            }
        }
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
        if segue.identifier == "toRequestDetails" {
            if let vc = segue.destination as? DetailRequestViewController, let offer = sender as? Offer {
                vc.offer = offer
            }
        } else if segue.identifier == "toOfferDetails" {
            if let vc = segue.destination as? MyOfferItemViewController, let offer = sender as? Offer {
                vc.offer = offer
            }
        } else if segue.identifier == "toUpdateProfile", let vc = segue.destination as? EditProfileViewController {
            vc.profile = profile
        }
    }
    

}
