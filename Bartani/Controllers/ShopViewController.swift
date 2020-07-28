//
//  ShopViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    var products = [Product]()

    @IBOutlet weak var searchBar: UISearchBar!
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
        cell.checkmarkImage.alpha = 0
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
        
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            CloudKitHelper.searchProducts(search: text) { (records) in
                self.products = records
                DispatchQueue.main.async {
                    self.productCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CloudKitHelper.fetchMyOffers()
        CloudKitHelper.fetchMyRequests()
        CloudKitHelper.fetchProducts { (records) in
            self.products = records
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }
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
