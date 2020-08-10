//
//  User.swift
//  Bartani
//
//  Created by Rahman Fadhil on 10/08/20.
//  Copyright © 2020 Rahman Fadhil. All rights reserved.
//

import UIKit
import CloudKit

struct Profile {
    var name: String
    var phone: String?
    var bio: String?
    var profileImage: UIImage?
    
    static func fromRecord(record: CKRecord) -> Profile {
        var profile = Profile(
            name: record.value(forKey: "name") as? String ?? "Unknown",
            phone: record.value(forKey: "phone") as? String,
            bio: record.value(forKey: "bio") as? String,
            profileImage: nil
        )
        
        if let image = record.value(forKey: "profileImage") as? CKAsset, let url = image.fileURL, let data = NSData(contentsOf: url) {
            profile.profileImage = UIImage(data: data as Data)
        }
        
        return profile
    }
}
