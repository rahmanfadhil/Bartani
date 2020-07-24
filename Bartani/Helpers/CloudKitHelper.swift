//
//  CloudKitHelper.swift
//  Bartani
//
//  Created by Rahman Fadhil on 22/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import Foundation
import CloudKit

struct CloudKitHelper {
    struct RecordType {
        static let Products = "Products"
    }
    
    struct InsertProduct {
        let title: String
        let price: Int
        let quantity: String
        let address: String
        let imageURL: URL
    }
    
    // MARK: - Save product

    static func saveProduct(data: InsertProduct, onComplete: @escaping () -> Void) {
        let product = CKRecord(recordType: RecordType.Products)
        product.setValue(data.title, forKey: "title")
        product.setValue(data.price, forKey: "price")
        product.setValue(data.quantity, forKey: "quantity")
        product.setValue(data.address, forKey: "address")
        product.setValue(CKAsset(fileURL: data.imageURL), forKey: "image")
        
        CKContainer.default().publicCloudDatabase.save(product) { (record, error) in
            if let error = error {
                print(error)
                return
            }
            
            onComplete()
        }
    }
    
    // MARK: - All products
    
    static func fetchProducts(onComplete: @escaping ([Product]) -> Void) {
        let container = CKContainer.default()
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordType.Products, predicate: predicate)
        
        container.publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let records = records else { return }
            onComplete(Product.fromRecords(data: records))
        }
    }
    
    // MARK: - Current user products
    
    static func fetchMyProducts(onComplete: @escaping ([Product]) -> Void) {
        let container = CKContainer.default()
        
        container.fetchUserRecordID { (userID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let reference = CKRecord.Reference(recordID: userID!, action: .none)
            let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
            let query = CKQuery(recordType: RecordType.Products, predicate: predicate)
            
            container.publicCloudDatabase.perform(query, inZoneWith: nil) { (records, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }

                guard let records = records else { return }
                onComplete(Product.fromRecords(data: records))
            }
        }
    }
}
