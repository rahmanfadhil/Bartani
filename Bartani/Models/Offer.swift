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
    var ckRecord: CKRecord
    var buyerName: String
    var sellerName: String
    var buyerProduct: Product
    var sellerProduct: Product
}
