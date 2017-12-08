//
//  AreaResponseModel.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 08.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation

class ProvinceResponseModel {
    var id: Int
    var name: String
    
    init?(with dictionary: Dictionary<String, Any>?) {
        guard let dictionary = dictionary else {
            return nil
        }
        self.id = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
    }
}

class AreaResponseModel {
    var id: Int
    var name: String
    var lat: Double
    var lng: Double
    var province: ProvinceResponseModel?
    
    init(with dictionary: Dictionary<String, Any>) {
        self.id = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
        self.lat = dictionary["lat"] as? Double ?? 0.0
        self.lng = dictionary["lng"] as? Double ?? 0.0
        self.province = ProvinceResponseModel(with: dictionary["province"] as? Dictionary<String, Any>)
    }
}
