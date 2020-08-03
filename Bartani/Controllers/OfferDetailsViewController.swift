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
    
    var product: Product?
    var sellerProduct: Product?
    var buyerProduct: Product?
    
    var delegate: ProductDetailDelegate?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAccept.layer.cornerRadius = 6
        buttonAccept.layer.borderColor = #colorLiteral(red: 1, green: 0.5575068593, blue: 0, alpha: 1)
        
        buttonDecline.layer.cornerRadius = 6
        
        
        labelProductName.text = product?.title
        imageProduct.image = product?.image
        labelProductQuantity.text = product?.quantity
        labelDescription.text = product?.description
        
        if let price = product?.price {
            labelProductPrice.text = "Rp \(price)"
        }
        
        locationManager.delegate = self
        
        
        
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
        if let location = locations.first, let productLocation = product?.location {
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
            if let vc = segue.destination as? BarterViewController {
                vc.product = product
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
