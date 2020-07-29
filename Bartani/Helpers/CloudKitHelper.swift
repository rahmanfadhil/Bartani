//
//  CloudKitHelper.swift
//  Bartani
//
//  Created by Rahman Fadhil on 22/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

struct CloudKitHelper {
    struct RecordType {
        static let Products = "Products"
        static let Offers = "Offers"
    }
    
    struct InsertProduct {
        let title: String
        let price: Int
        let quantity: String
        let description: String
        let imageURL: URL
        let location: CLLocation
    }
    
    struct InsertOffer {
        let buyerName: String
        let sellerName: String
        let buyerProduct: CKRecord
        let sellerProduct: CKRecord
    }
    
    // MARK: - Save product

    static func saveProduct(data: InsertProduct, onComplete: @escaping () -> Void) {
        let product = CKRecord(recordType: RecordType.Products)
        product.setValue(data.title, forKey: "title")
        product.setValue(data.price, forKey: "price")
        product.setValue(data.quantity, forKey: "quantity")
        product.setValue(data.description, forKey: "description")
        product.setValue(CKAsset(fileURL: data.imageURL), forKey: "image")
        product.setValue(data.location, forKey: "location")
        
        CKContainer.default().publicCloudDatabase.save(product) { (record, error) in
            if let error = error {
                print(error)
                return
            }
            
            onComplete()
        }
    }
    
    // MARK: - Save offer
    
    static func saveOffer(data: InsertOffer, onComplete: @escaping () -> Void) {
        let offer = CKRecord(recordType: RecordType.Offers)
        offer.setValue(data.buyerName, forKey: "buyerName")
        offer.setValue(data.sellerName, forKey: "sellerName")
        let buyerProductReference = CKRecord.Reference(record: data.buyerProduct, action: .deleteSelf)
        offer.setValue(buyerProductReference, forKey: "buyerProduct")
        let sellerProductReference = CKRecord.Reference(record: data.sellerProduct, action: .deleteSelf)
        offer.setValue(sellerProductReference, forKey: "sellerProduct")
        
        if let userID = data.buyerProduct.creatorUserRecordID, let sellerID = data.sellerProduct.creatorUserRecordID {
            let buyer = CKRecord.Reference(recordID: userID, action: .none)
            let seller = CKRecord.Reference(recordID: sellerID, action: .none)
            offer.setValue(buyer, forKey: "buyer")
            offer.setValue(seller, forKey: "seller")
            
            CKContainer.default().publicCloudDatabase.save(offer) { (record, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                onComplete()
            }
        }
    }
    
    // MARK: - Search products
    
    static func searchProducts(search: String, onComplete: @escaping ([Product]) -> Void) {
        let container = CKContainer.default()
        var predicate: NSPredicate
        
        if search.count >= 1 {
            predicate = NSPredicate(format: "allTokens TOKENMATCHES[cdl] %@", search)
        } else {
            predicate = NSPredicate(value: true)
        }
        
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
    
    // MARK: - Fetch my barter offers
    
    static func fetchMyOffers() {
        let container = CKContainer.default()
        
        container.fetchUserRecordID { (userID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let reference = CKRecord.Reference(recordID: userID!, action: .none)
            let predicate = NSPredicate(format: "buyer == %@", reference)
            let query = CKQuery(recordType: RecordType.Offers, predicate: predicate)
            
            container.publicCloudDatabase.perform(query, inZoneWith: nil) { (records, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }

                guard let records = records else { return }
                print(records)
            }
        }
    }
    
    // MARK: - Fetch my requests from other people
    
    static func fetchMyRequests() {
        let container = CKContainer.default()
        
        container.fetchUserRecordID { (userID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let reference = CKRecord.Reference(recordID: userID!, action: .none)
            let predicate = NSPredicate(format: "seller == %@", reference)
            let query = CKQuery(recordType: RecordType.Offers, predicate: predicate)
            
            container.publicCloudDatabase.perform(query, inZoneWith: nil) { (records, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }

                guard let records = records else { return }
                print(records)
            }
        }
    }
}
