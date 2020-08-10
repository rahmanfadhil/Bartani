//
//  SetLocationViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 24/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SetLocationViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    var productData: NewProductData?
    
    var currentLocation: MKPointAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

        // Style confirm button
        confirmButton.layer.cornerRadius = 6
        confirmButton.layer.shadowOffset = .zero
        confirmButton.layer.shadowOpacity = 0.5
        confirmButton.layer.shadowRadius = 3
        confirmButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        
        checkLocationServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleLongPress(_:))
        )
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            // Do map stuff
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
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc func handleLongPress(_ gestureRecognizer : UIGestureRecognizer){
        if gestureRecognizer.state == .ended {
            print("HELLO!")
            
            let touchPoint = gestureRecognizer.location(in: mapView)
            let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchMapCoordinate
            annotation.title = "Product Location"
            annotation.subtitle = "This is the location of you and your product"
            
            if let currentLocation = currentLocation {
                mapView.removeAnnotation(currentLocation)
            }
            
            mapView.addAnnotation(annotation)
            currentLocation = annotation
            

            mapView.addAnnotation(annotation)
        }
    }
    
    
    @IBAction func confirmTapped(_ sender: Any) {
        if let currentLocation = currentLocation, let data = productData {
            CloudKitHelper.saveProduct(data: CloudKitHelper.InsertProduct(
                title: data.title,
                price: data.price,
                quantity: data.quantity,
                description: data.description,
                imageURL: data.imageURL,
                location: CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude),
                harvestedAt: data.harvestedAt
            )) {
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toSuccess", sender: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Please select a location", message: "You must select the location of you and your product", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
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
