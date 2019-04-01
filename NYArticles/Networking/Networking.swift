//
//  Networking.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

typealias SuccessHandler = (Data?, JSON?) -> ()
typealias ErrorHandler = (Error) -> ()

protocol Networking {
    func send(path: String, method: HTTPMethod, params: [String: String], success: @escaping SuccessHandler, failure: @escaping ErrorHandler)
}

