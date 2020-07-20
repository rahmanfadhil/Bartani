//
//  ShopViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

struct Product {
    var title: String
    var price: Int
}

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var products = [
        Product(title: "Cabai", price: 3500),
        Product(title: "Bayam", price: 4000),
        Product(title: "Cabai", price: 3500),
        Product(title: "Bayam", price: 4000),
        Product(title: "Cabai", price: 3500),
        Product(title: "Bayam", price: 4000),
        Product(title: "Cabai", price: 3500),
        Product(title: "Bayam", price: 4000),
        Product(title: "Cabai", price: 3500),
        Product(title: "Bayam", price: 4000),
        Product(title: "Cabai", price: 3500),
        Product(title: "Bayam", price: 4000),
        Product(title: "Cabai", price: 3500),
        Product(title: "Bayam", price: 4000)
    ]

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.priceLabel.text = "\(product.price)"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "productCell")

        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        productCollectionView.showsVerticalScrollIndicator = false
        navigationController?.isNavigationBarHidden = true
        
        // Do any additional setup after loading the view.
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
