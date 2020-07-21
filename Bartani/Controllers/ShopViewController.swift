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
    var quantity: String
    var image: UIImage?
}

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var products = [
        Product(title: "Bayam", price: 5500, quantity: "1 ikat", image: UIImage(named: "bayam")),
        Product(title: "Cabai", price: 7000, quantity: "1,5 kg", image: UIImage(named: "cabai")),
        Product(title: "Kentang", price: 8000, quantity: "5 buah", image: UIImage(named: "kentang")),
        Product(title: "Kangkung", price: 3000, quantity: "2 ikat", image: UIImage(named: "kangkung")),
        Product(title: "Bayam", price: 5500, quantity: "1 ikat", image: UIImage(named: "bayam")),
        Product(title: "Cabai", price: 7000, quantity: "1,5 kg", image: UIImage(named: "cabai")),
        Product(title: "Kentang", price: 8000, quantity: "5 buah", image: UIImage(named: "kentang")),
        Product(title: "Kangkung", price: 3000, quantity: "2 ikat", image: UIImage(named: "kangkung"))
    ]

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.priceLabel.text = "Rp \(product.price)"
        cell.thumbnailImage.image = product.image
        cell.amountLabel.text = product.quantity
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        performSegue(withIdentifier: "toProductDetail", sender: product)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "productCell")

        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        navigationController?.isNavigationBarHidden = true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ProductDetailViewController, let product = sender as? Product {
            vc.product = product
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
