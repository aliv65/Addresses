//
//  AddressResponseModel.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 07.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation

class AddressResponseModel {
    var name: String
    var areaId: Int
    var area: String
    var apartment: String
    var apartmentNo: String
    var block: String
    var street: String
    var floor: Int
    var phone: String
    var instructions: String
    var preview: String
    var province: String
    var lat: Double
    var lng: Double
    

    init(with dictionary: Dictionary<String, Any>) {
        self.name = dictionary["label"] as? String ?? ""
        self.areaId = dictionary["area_id"] as? Int ?? 0
        self.area = dictionary["area"] as? String ?? ""
        self.apartment = dictionary["apartment"] as? String ?? ""
        self.block = dictionary["block"] as? String ?? ""
        self.street = dictionary["street"] as? String ?? ""
        self.floor = dictionary["floor"] as? Int ?? 0
        self.apartmentNo = dictionary["apartment_no"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.instructions = dictionary["location_instructions"] as? String ?? ""
        self.lat = dictionary["lat"] as? Double ?? 0.0
        self.lng = dictionary["lng"] as? Double ?? 0.0
        self.preview = dictionary["preview"] as? String ?? ""
        self.province = dictionary["province"] as? String ?? ""
    }
    
    func toDictionary() -> [String: String] {
        var result = [String: String]()
        result["label"] = self.name
        result["area"] = self.area
        result["apartment"] = self.apartment
        result["block"] = self.block
        result["street"] = self.street
        result["floor"] = self.floor == 0 ? "" : "\(self.floor)"
        result["apartment_no"] = self.apartmentNo
        result["phone"] = self.phone
        result["location_instructions"] = self.instructions
        result["preview"] = self.preview
        result["province"] = self.province
        return result
    }
}
