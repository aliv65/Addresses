//
//  AreaResponseModel.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 08.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseAreaResponseModel: Mappable {
    var areas: [AreaResponseModel]?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        areas <- map["areas"]
    }
}

class AreaResponseModel: Mappable {
    private var id: Int?
    private var name: String?
    private var lat: Double?
    private var lng: Double?
    var province: ProvinceResponseModel?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
        lat         <- map["lat"]
        lng         <- map["lng"]
        province    <- map["province"]
    }
    
    var areaName: String {
        return name ?? ""
    }
    
    var areaLatitude: Double {
        return lat ?? 0.0
    }
    
    var areaLongitude: Double {
        return lng ?? 0.0
    }
}

class ProvinceResponseModel: Mappable {
    private var id: Int?
    private var name: String?
    
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id          <- map["id"]
        name        <- map["name"]
    }
    
    var provinceName: String {
        return name ?? ""
    }
}

