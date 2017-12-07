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
        return []
    }
    
    var hasAddresses: Bool {
        return !addresses.isEmpty
    }
    
    func getAddress(for latitude: Double, longitude: Double,completion: @escaping ([Address]) -> Void) {
        
    }
    
    func save(address: Address, completion: @escaping (Bool) -> Void) {
        
    }
}
