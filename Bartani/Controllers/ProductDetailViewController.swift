//
//  ProductDetailViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftUI
import Combine

protocol ProductDetailDelegate {
    func searchProducts(text: String)
}

class ProductDetailViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
    var product: Product?
    var delegate: ProductDetailDelegate?
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var barterButton: UIButton!
    @IBOutlet weak var productThumbnailImage: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var sellerDistanceLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: VerticalTopAlignLabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barterButton.layer.cornerRadius = 6
        
        productTitleLabel.text = product?.title
        
        productThumbnailImage.image = product?.image
        
        if let date = product?.harvestedAt, let quantity = product?.quantity {
            let formatter = RelativeDateTimeFormatter()
            let time = formatter.localizedString(for: date, relativeTo: Date())
            productQuantityLabel.text = "\(quantity) - harvested \(time)"
        }
        
        
        if let price = product?.price {
            productPriceLabel.text = "Rp \(price)"
        }
        
        locationManager.delegate = self
        
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        productDescriptionLabel.text = product?.description
        
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization(CLLocationManager.authorizationStatus())
        } else {
            // Show alert
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            navigationController?.popViewController(animated: true)
            delegate?.searchProducts(text: text)
        }
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
            sellerDistanceLabel.text = "\(String(format: "%.1f", distance)) km"
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBarter" {
            if let vc = segue.destination as? BarterViewController {
                vc.product = product
            }
        }
    }

}
