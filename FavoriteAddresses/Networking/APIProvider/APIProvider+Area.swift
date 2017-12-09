//
//  APIProvider+Area.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 08.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import Alamofire

extension APIProvider {
    func areas(completion: @escaping ([AreaResponseModel]?, Error?) -> Void) {
        Alamofire.request(APIRouter.areas).responseJSON { (response) in
            print("response: \(response)")
            switch response.result {
            case .success(let responseObject):
                guard let responseDictionary = responseObject as? Dictionary<String, Any> else {
                    return
                }
                guard let areasArray = responseDictionary["areas"] as? [Dictionary<String, Any>] else {
                    return
                }
                var areas = [AreaResponseModel]()
                for areaDictionary in areasArray {
                    areas.append(AreaResponseModel(with: areaDictionary))
                }
                completion(areas, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
