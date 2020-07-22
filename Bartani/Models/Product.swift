//
//  Product.swift
//  Bartani
//
//  Created by Rahman Fadhil on 22/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit
import CloudKit

struct Product {
    var title: String
    var price: Int
    var quantity: String
    var address: String
    var image: UIImage?
    
    static func fromRecords(data: [CKRecord]) -> [Product] {
        data.map { (record) -> Product in
            return Product(
                title: record.value(forKey: "title") as? String ?? "",
                price: record.value(forKey: "price") as? Int ?? 0,
                quantity: record.value(forKey: "quantity") as? String ?? "",
                address: record.value(forKey: "address") as? String ?? "",
                image: UIImage(named: "cabai")
            )
        }
    }
}
