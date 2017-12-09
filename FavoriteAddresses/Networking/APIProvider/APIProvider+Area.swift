//
//  APIProvider+Area.swift
//  FavoriteAddresses
//
//  Created by Aleksander Ivanin on 08.12.2017.
//  Copyright © 2017 MobileDev. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

extension APIProvider {
    func areas(completion: @escaping ([AreaResponseModel]?, Error?) -> Void) {
        Alamofire.request(APIRouter.areas).responseObject { (response: DataResponse<BaseAreaResponseModel>) in
            print("response: \(response)")
            switch response.result {
            case .success(_):
                guard let baseAreaResponse = response.result.value,
                    let areas = baseAreaResponse.areas else {
                        completion(nil, nil)
                        return
                }
                completion(areas, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
