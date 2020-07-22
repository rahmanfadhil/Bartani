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
    
    // MARK: - Save product
    
    static func saveProduct(data: Product) {
        let product = CKRecord(recordType: RecordType.Products)
        product.setValue(data.title, forKey: "title")
        product.setValue(data.price, forKey: "price")
        product.setValue(data.quantity, forKey: "quantity")
        
        CKContainer.default().publicCloudDatabase.save(product) { (record, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let record = record else { return }
            print(record)
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
