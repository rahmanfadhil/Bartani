//
//  MyOfferItemViewController.swift
//  Bartani
//
//  Created by Arif Rahman Sidik on 28/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class MyOfferItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
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
        selectProduct = products[indexPath.row]
        performSegue(withIdentifier: "toOfferDetail", sender: product)
    }
    

    var products = [Product]()
    
    
    var selectProduct: Product?
    var product: Product?
    var sellerProduct: Product?
    var buyerProduct: Product?
    
    
    @IBOutlet weak var viewProductBox: UIView!
    @IBOutlet weak var titleOfferLabel: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductQuantity: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var labelRequestItem: UILabel!
    @IBOutlet weak var collectionViewRequestItem: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CloudKitHelper.fetchProducts { (records) in
            self.products = records
            DispatchQueue.main.async {
                self.collectionViewRequestItem.reloadData()
            }
        }
        
        labelProductName.text = product?.title
        labelProductQuantity.text = product?.quantity
        imageProduct.image = product?.image
               
        let path = UIBezierPath(roundedRect: imageProduct.bounds, byRoundingCorners:[.bottomLeft, .topLeft], cornerRadii: CGSize(width: 7, height: 7))
               let maskLayer = CAShapeLayer()

               maskLayer.path = path.cgPath
               imageProduct.layer.mask = maskLayer
               
               viewProductBox.layer.shadowOffset = .zero
               viewProductBox.layer.shadowOpacity = 0.5
               viewProductBox.layer.shadowRadius = 3
               viewProductBox.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
               viewProductBox.layer.masksToBounds = false
               viewProductBox.layer.cornerRadius = 7
               
               if let price = product?.price {
                   labelProductPrice.text = "Rp \(price)"
               }
               
               collectionViewRequestItem.delegate = self
               collectionViewRequestItem.dataSource = self
               
               let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
               collectionViewRequestItem.register(nib, forCellWithReuseIdentifier: "productCell")
           }
        // Do any additional setup after loading the view.
    }

 // MARK: - Appear and dissapear
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//
//        CloudKitHelper.fetchMyProducts { (products) in
//            self.products = products
//
//            DispatchQueue.main.async {
//                self.productCollectionView.reloadData()
//            }
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
