//
//  MyOfferItemViewController.swift
//  Bartani
//
//  Created by Arif Rahman Sidik on 28/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class MyOfferItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var viewProductBox: UIView!
    @IBOutlet weak var titleOfferLabel: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var labelProductName: UILabel!
    @IBOutlet weak var labelProductQuantity: UILabel!
    @IBOutlet weak var labelProductPrice: UILabel!
    @IBOutlet weak var labelRequestItem: UILabel!
    @IBOutlet weak var collectionViewRequestItem: UICollectionView!
    
    var products = [Product]()
    
    var selectProduct: Product?
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("cetak")
    
        
        labelProductName.text = product?.title
        imageProduct.image = product?.image
        labelProductQuantity.text = product?.quantity
        
//        labelProductName.text = selectProduct?.title
//        labelProductQuantity.text = selectProduct?.quantity
//        imageProduct.image = selectProduct?.image
               
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
                   
        if let price = selectProduct?.price {
            labelProductPrice.text = "Rp \(price)"
        }
                   
        collectionViewRequestItem.delegate = self
        collectionViewRequestItem.dataSource = self
                   
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
                 collectionViewRequestItem.register(nib, forCellWithReuseIdentifier: "productCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        //1. select database
        //udah ada di helper
        //2. select record
        //udah ada helper
        //3.excecute query
        CloudKitHelper.fetchMyProducts { (record) in
            self.products = record
            DispatchQueue.main.async {
                self.collectionViewRequestItem.reloadData()
            }
        }
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectProduct = products[indexPath.row]
        performSegue(withIdentifier: "toOfferDetail", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toOfferDetails", let vc = segue.destination as? OfferDetailsViewController, let product = sender as? Product{
        vc.product = product
        }
    }
    
    
}

