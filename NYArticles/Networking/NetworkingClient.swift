//
//  NetworkingClient.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

fileprivate let BaseURL = "https://api.nytimes.com/svc/mostpopular/v2/"
fileprivate let ApiKey = "?api-key=H9aNlNCiq64Te3E0nP4RVHFo1k7t2HD7"

class NetworkingClient: Networking {
    
    func send(path: String, method: HTTPMethod, params: [String: String], success: @escaping SuccessHandler, failure: @escaping ErrorHandler) {
        self.send(url: BaseURL + path + ApiKey,
                  method: method,
                  params: params,
                  success: success,
                  failure: failure)
    }
    
    func send(url: String, method: HTTPMethod, params: [String: String], success: @escaping SuccessHandler, failure: @escaping ErrorHandler) {
        Alamofire
            .request(url, method: method, parameters: params)
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    success(response.data, JSON(data))
                case .failure(let error):
                    failure(error)
                }
        }
    }
}


