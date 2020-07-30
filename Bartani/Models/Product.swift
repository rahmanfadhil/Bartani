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
    var description: String
    var location: CLLocation?
    var image: UIImage?
    var ckRecord: CKRecord
    var harvestedAt: Date
    
    static func fromRecords(data: [CKRecord]) -> [Product] {
        var products = [Product]()
        
        for record in data {
            if let product = fromRecord(record: record) {
                products.append(product)
            }
        }
        
        return products
    }
    
    static func fromRecord(record: CKRecord) -> Product? {
        if let image = record.value(forKey: "image") as? CKAsset, let url = image.fileURL, let data = NSData(contentsOf: url), let date = record.value(forKey: "harvestedAt") as? Date {
            return Product(
                title: record.value(forKey: "title") as? String ?? "",
                price: record.value(forKey: "price") as? Int ?? 0,
                quantity: record.value(forKey: "quantity") as? String ?? "",
                description: record.value(forKey: "description") as? String ?? "",
                location: record.value(forKey: "location") as? CLLocation,
                image: UIImage(data: data as Data),
                ckRecord: record,
                harvestedAt: date
            )
        }
        
        return nil
    }
}
