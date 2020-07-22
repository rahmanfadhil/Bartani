//
//  BarterViewController.swift
//  Bartani
//
//  Created by Rahman Fadhil on 17/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit

class BarterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var products = [Product]()
    
    var product: Product?
    
    // MARK: - Outlets

    @IBOutlet weak var productBox: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var proceedButton: UIButton!
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proceedButton.layer.cornerRadius = 10
        
        productTitleLabel.text = product?.title
        productQuantityLabel.text = product?.quantity
        productImage.image = product?.image
        
        let path = UIBezierPath(roundedRect: productImage.bounds, byRoundingCorners:[.bottomLeft, .topLeft], cornerRadii: CGSize(width: 7, height: 7))
        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        productImage.layer.mask = maskLayer
        
        productBox.layer.shadowOffset = .zero
        productBox.layer.shadowOpacity = 0.5
        productBox.layer.shadowRadius = 3
        productBox.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        productBox.layer.masksToBounds = false
        productBox.layer.cornerRadius = 7
        
        if let price = product?.price {
            productPriceLabel.text = "Rp \(price)"
        }
        
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCollectionView.register(nib, forCellWithReuseIdentifier: "productCell")
    }
    
    // MARK: - Appear and dissapear
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        CloudKitHelper.fetchMyProducts { (products) in
            self.products = products
            
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Collection view
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
