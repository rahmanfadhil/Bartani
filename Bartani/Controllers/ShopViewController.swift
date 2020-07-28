//
//  ShopViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, ProductDetailDelegate {
    
    var products = [Product]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        return refreshControl
    }()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    // MARK: - Collection view
    
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
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "productCell")

        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        navigationController?.isNavigationBarHidden = true
        
        searchBar.delegate = self
        
        productCollectionView.refreshControl = refreshControl
        
        CloudKitHelper.fetchProducts { (records) in
            self.products = records
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - Search bar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchProducts(text: text)
        }
    }
    
    // MARK: - Search proudcts
    
    func searchProducts(text: String) {
        CloudKitHelper.searchProducts(search: text) { (records) in
            self.products = records
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - Refresh control
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        CloudKitHelper.fetchProducts { (records) in
            self.products = records
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductDetail", let vc = segue.destination as? ProductDetailViewController, let product = sender as? Product {
            vc.product = product
            vc.delegate = self
        }
    }

}
