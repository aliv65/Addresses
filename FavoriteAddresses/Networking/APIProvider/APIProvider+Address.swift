//
//  APIProvider+Address.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 06.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import Alamofire

extension APIProvider {
    func addresses(for latitude: Double, longitude: Double, completion: @escaping (AddressResponseModel?, Error?) -> Void) {
        Alamofire.request(APIRouter.address(latitude, longitude)).responseJSON { (response) in
            print("response: \(response)")
            switch response.result {
            case .success(let responseObject):
                guard let responseDictionary = responseObject as? Dictionary<String, Any> else {
                    return
                }
                guard let addressDictionary = responseDictionary["address"] as? Dictionary<String, Any> else {
                    return
                }
                let addressResponse = self.parseAddress(from: addressDictionary)
                completion(addressResponse, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func parseAddress(from dictionary: Dictionary<String, Any>) -> AddressResponseModel {
        let result = AddressResponseModel()
        result.preview = dictionary["preview"] as? String
        result.block = dictionary["preview"] as? String
        result.province = dictionary["province"] as? String
        result.street = dictionary["street"] as? String
        result.areaId = dictionary["area_id"] as? Int
        result.area = dictionary["area"] as? String
        return result
    }
}
