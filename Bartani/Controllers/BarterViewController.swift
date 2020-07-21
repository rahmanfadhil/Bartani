//
//  BarterViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class BarterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    var product: Product?

    @IBOutlet weak var productBox: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productBox.layer.cornerRadius = 10
        productBox.clipsToBounds = true
        
        productTitleLabel.text = product?.title
        productQuantityLabel.text = product?.quantity
        productImage.image = product?.image
        
        if let price = product?.price {
            productPriceLabel.text = "Rp \(price)"
        }
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "productCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let product = products[indexPath.row]
        cell.titleLabel.text = product.title
        cell.priceLabel.text = "Rp \(product.price)"
        cell.thumbnailImage.image = product.image
        cell.amountLabel.text = product.quantity
        cell.boxView.backgroundColor = UIColor.systemGray6
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
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
