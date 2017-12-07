//
//  APIRouter.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 06.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    static let baseURLPath = "http://staging.salony.com/v5"
    
    case address(Double, Double)
    case areas
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .address:
            return "/addresses/geolocate"
        case .areas:
            return "/areas"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .address(let lat, let lng):
                return ["lat" : lat, "lng" : lng]
            default:
                return [:]
            }
        }()
        
        let url = try APIRouter.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
