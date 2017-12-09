//
//  AddressResponseModel.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 07.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseAddressResponseModel: Mappable {
    var address: AddressResponseModel?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        address <- map["address"]
    }
}

class AddressResponseModel: Mappable {
    private var name: String?
    private var areaId: Int?
    private var area: String?
    private var apartment: String?
    private var apartmentNo: String?
    private var block: String?
    private var street: String?
    private var floor: Int?
    private var phone: String?
    private var instructions: String?
    private var preview: String?
    private var province: String?
    private var lat: Double?
    private var lng: Double?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        name            <- map["label"]
        areaId          <- map["area_id"]
        area            <- map["area"]
        apartment       <- map["apartment"]
        apartmentNo     <- map["apartment_no"]
        block           <- map["block"]
        street          <- map["street"]
        floor           <- map["floor"]
        phone           <- map["phone"]
        instructions    <- map["location_instructions"]
        lat             <- map["lat"]
        lng             <- map["lng"]
        preview         <- map["preview"]
        province        <- map["province"]
    }
    
    func toDictionary() -> [String: String] {
        var result = [String: String]()
        result["label"] = self.addressName
        result["area"] = self.addressArea
        result["apartment"] = self.addressApartment
        result["apartment_no"] = self.addressApartmentNo
        result["block"] = self.addressBlock
        result["street"] = self.addressStreet
        result["floor"] = self.addressFloor == 0 ? "" : "\(self.addressFloor)"
        result["phone"] = self.addressPhone
        result["location_instructions"] = self.addressInstructions
        result["preview"] = self.addressPreview
        result["province"] = self.addressProvince
        return result
    }
    
    var addressName: String {
        return name ?? ""
    }
    
    var addressArea: String {
        return area ?? ""
    }
    
    var addressApartment: String {
        return apartment ?? ""
    }
    
    var addressApartmentNo: String {
        return apartmentNo ?? ""
    }
    
    var addressBlock: String {
        return block ?? ""
    }
    
    var addressStreet: String {
        return street ?? ""
    }
    
    var addressFloor: Int {
        return floor ?? 0
    }
    
    var addressPhone: String {
        return phone ?? ""
    }
    
    var addressInstructions: String {
        return instructions ?? ""
    }
    
    var addressPreview: String {
        return preview ?? ""
    }
    
    var addressProvince: String {
        return province ?? ""
    }
    
    var addressAreaId: Int {
        return areaId ?? 0
    }
    
    var addressLatitude: Double {
        return lat ?? 0.0
    }
    
    var addressLongitude: Double {
        return lng ?? 0.0
    }
}
