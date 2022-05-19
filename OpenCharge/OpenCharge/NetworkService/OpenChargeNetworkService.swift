//
//  OpenChargeNetworkService.swift
//  OpenCharge
//
//  Created by Onur Ustunel on 16.05.2022.
//

import UIKit
import Alamofire

protocol IOpenChargeNetworkService {
    func fetchAllData(completion: @escaping ([ChargerInfo]?) -> Void)
}

struct OpenChargeNetworkService: IOpenChargeNetworkService  {
    /// This function sends network request and gives [ChargerInfo] type data.
    /// - Parameter completion: [ChargerInfo] base model type
    func fetchAllData(completion: @escaping ([ChargerInfo]?) -> Void) {
        let url = "https://api.openchargemap.io/v3/poi?"
        let parameters: [String: String] = ["key": "\(apiKey)",
                                            "latitude" : "\(Constants.location.latitude)",
                                            "longitude" : "\(Constants.location.longitude)",
                                            "distance" : "\(Constants.distance)",
                                            "distanceunit" : Constants.distanceunit]
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: [ChargerInfo].self) { response in
                guard let data = response.value else {
                    completion(nil)
                    return
                }
                completion(data)
            }
    }
    
}

extension OpenChargeNetworkService {
    /// our secret api key
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "OpenCharge", ofType: "plist") else {
                fatalError("Couldn't find file OpenCharge.plist.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in OpenCharge.plist.")
            }
            return value
        }
    }
}



