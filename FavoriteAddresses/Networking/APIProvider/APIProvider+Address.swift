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
    func addresses(for latitude: Double, longitude: Double, completion: @escaping (Address?, Error?) -> Void) {
        Alamofire.request(APIRouter.address(latitude, longitude)).responseJSON { (response) in
            print("response: \(response)")
            switch response.result {
            case .success(let responseObject):
                completion(nil, nil)
            case .failure(let error):
                completion(nil, error)
            }
            
//            completion(<#Address#>)
        }
    }
    
    func parseAddress(from dictionary: Dictionary<String, Any>) {
        
    }
}
