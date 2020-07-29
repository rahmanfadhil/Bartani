//
//  Offer.swift
//  Bartani
//
//  Created by Rahman Fadhil on 22/07/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import Foundation
import CloudKit

struct Offer {
    var buyerName: String
    var sellerName: String
    var buyerProduct: Product?
    var sellerProduct: Product?
    
    static func fromRecords(records: [CKRecord]) -> [Offer] {
        return records.map { (record) -> Offer in
            Offer(
                buyerName: record.value(forKey: "buyerName") as? String ?? "",
                sellerName: record.value(forKey: "sellerName") as? String ?? "",
                buyerProduct: nil,
                sellerProduct: nil
            )
        }
    }
}
