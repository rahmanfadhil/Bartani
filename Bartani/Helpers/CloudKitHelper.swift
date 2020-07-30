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
    
    // MARK: - Fetch my requests to other people
    
    static func fetchMyRequest(onComplete: @escaping ([Offer]) -> Void) {
        let container = CKContainer.default()
        
        container.fetchUserRecordID { (userID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let reference = CKRecord.Reference(recordID: userID!, action: .none)
            let predicate = NSPredicate(format: "buyer == %@", reference)
            let query = CKQuery(recordType: RecordType.Offers, predicate: predicate)
            
            queryOffers(container: container, query: query) { offers in
                onComplete(offers)
            }
        }
    }
    
    // MARK: - Fetch other people's offers to my products
    
    static func fetchMyOffers(onComplete: @escaping ([Offer]) -> Void) {
        let container = CKContainer.default()
        
        container.fetchUserRecordID { (userID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let reference = CKRecord.Reference(recordID: userID!, action: .none)
            let predicate = NSPredicate(format: "seller == %@", reference)
            let query = CKQuery(recordType: RecordType.Offers, predicate: predicate)
            
            queryOffers(container: container, query: query) { offers in
                onComplete(offers)
            }
        }
    }
    
    static func queryOffers(container: CKContainer, query: CKQuery, onComplete: @escaping ([Offer]) -> Void) {
        container.publicCloudDatabase.perform(query, inZoneWith: nil) { (records, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }

            guard let records = records else { return }
            
            var offers = [Offer]()
            
            let mainGroup = DispatchGroup()
            
            for record in records {
                mainGroup.enter()
                if let spReference = record.value(forKey: "sellerProduct") as? CKRecord.Reference, let bpReference = record.value(forKey: "buyerProduct") as? CKRecord.Reference {
                    var sellerProduct: Product?
                    var buyerProduct: Product?
                    
                    let group = DispatchGroup()
                    group.enter()
                    getProductFromId(id: spReference.recordID) { (product) in
                        sellerProduct = product
                        group.leave()
                    }
                    group.enter()
                    getProductFromId(id: bpReference.recordID) { (product) in
                        buyerProduct = product
                        group.leave()
                    }
                    group.notify(queue: .main) {
                        guard let sellerProduct = sellerProduct else { return }
                        guard let buyerProduct = buyerProduct else { return }
                        offers.append(Offer(
                            buyerName: record.value(forKey: "buyerName") as? String ?? "",
                            sellerName: record.value(forKey: "sellerName") as? String ?? "",
                            buyerProduct: sellerProduct,
                            sellerProduct: buyerProduct
                        ))
                        mainGroup.leave()
                    }
                }
            }
            
            mainGroup.notify(queue: .main) {
                onComplete(offers)
            }
        }
    }
    
    static func getProductFromId(id: CKRecord.ID, onComplete: @escaping (Product) -> Void) {
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: id) { (record, err) in
            if let err = err {
                print(err.localizedDescription)
                return
            }
            
            if let record = record {
                if let product = Product.fromRecord(record: record) {
                    onComplete(product)
                }
            }
        }
        
    }
}
