//
//  OfferDetailsViewController.swift
//  Bartani
//
//  Created by Arif Rahman Sidik on 28/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit
import MapKit

class OfferDetailsViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductQuantity: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var labelUserDistance: UILabel!
    @IBOutlet weak var labelProductDescriptionTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonCallOwner: UIButton!
    @IBOutlet weak var buttonAccept: UIButton!
    @IBOutlet weak var buttonDecline: UIButton!
    @IBOutlet weak var backNavButton: UINavigationItem!

    
    var offer: Offer?
    var product: Product?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(offer)
        
        buttonAccept.layer.cornerRadius = 6
        buttonAccept.layer.borderWidth = 1
        buttonAccept.layer.borderColor = #colorLiteral(red: 1, green: 0.5575068593, blue: 0, alpha: 1)
        
        buttonDecline.layer.cornerRadius = 6
        
        
        labelProductName.text = offer?.buyerProduct.title
        imageProduct.image = offer?.buyerProduct.image
        labelProductQuantity.text = offer?.buyerProduct.quantity
        
        if let date = offer?.buyerProduct.harvestedAt, let quantity = offer?.buyerProduct.quantity {
            let formatter = RelativeDateTimeFormatter()
            let time = formatter.localizedString(for: date, relativeTo: Date())
            labelProductQuantity.text = "\(quantity) - harvested \(time)"
        }
        
        if let price = offer?.buyerProduct.price {
            labelProductPrice.text = "Rp \(price)"
        }
        
        locationManager.delegate = self
        labelDescription.text = offer?.buyerProduct.description
        
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization(CLLocationManager.authorizationStatus())
        } else {
            // Show alert
        }
        
   
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func acceptOffer(_ sender: Any) {
        //data diterima, ubah status jadi transaksi diterima
        
        
    }
    
    @IBAction func declineOffer(_ sender: Any) {
        // data di remove dari list offer
        
    }
    
    
    func checkLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            locationManager.requestLocation()
            break
        case .denied:
            // Show alert instructing them how to turn it on
            break
        case .notDetermined:
            // Request the permission
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Show alert letting them know what's up
            break
        case .authorizedAlways:
            break
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization(status)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, let productLocation = offer?.buyerProduct.location {
            let distance = location.distance(from: productLocation) / 1000
            labelUserDistance.text = "\(String(format: "%.1f", distance)) km"
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAcceptSuccess" {
            if let vc = segue.destination as? SuccesAcceptOfferViewController, let offer = sender{
                
            }
        }
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
