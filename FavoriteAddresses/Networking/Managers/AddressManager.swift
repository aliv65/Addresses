//
//  AddressManager.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 06.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import MagicalRecord

class AddressManager {
    static let shared = AddressManager()
    
    var addresses: [Address] {
        guard let addresses = Address.mr_findAll() as? [Address] else {
            return []
        }
        return addresses
    }
    
    var hasAddresses: Bool {
        return !addresses.isEmpty
    }
    
    func save(with model: AddressResponseModel, completion: @escaping (Bool) -> Void) {
        MagicalRecord.save({ (localContext) in
            guard let _ = Address.address(with: model, in: localContext) else {
                return
            }
        }) { (success, error) in
            completion(success)
        }
    }
}
