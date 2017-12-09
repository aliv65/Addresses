//
//  APIProvider+Address.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 06.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

extension APIProvider {
    func addresses(for latitude: Double, longitude: Double, completion: @escaping (AddressResponseModel?, Error?) -> Void) {
        Alamofire.request(APIRouter.address(latitude, longitude)).responseObject { (response: DataResponse<BaseAddressResponseModel>) in
            print("response: \(response)")
            switch response.result {
            case .success(_):
                guard let baseAddressResponse = response.result.value,
                    let addressResponse = baseAddressResponse.address else {
                    completion(nil, nil)
                    return
                }
                completion(addressResponse, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
