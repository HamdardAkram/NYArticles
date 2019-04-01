//
//  ArticlesInteractor.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ArticlesInteractorSuccessHandler = ([Article], Int) -> ()
typealias ArticlesInteractorFailureHandler = (Error) -> ()

protocol ArticlesInteractorProtocol {
    func fetchArticles(withOffset: Int, count: Int, success: @escaping ArticlesInteractorSuccessHandler, failure: @escaping ArticlesInteractorFailureHandler)
}

class ArticlesInteractor: ArticlesInteractorProtocol {
    
    fileprivate let networkClient: Networking
    
    var triggerOffset: Int = 5
    
    init(networkClient: Networking) {
        self.networkClient = networkClient
    }
    
    func fetchArticles(withOffset: Int, count: Int, success: @escaping ArticlesInteractorSuccessHandler, failure: @escaping ArticlesInteractorFailureHandler) {
        
        self.networkClient.send(path: "emailed/7.json", method: .get, params: [:], success: { (data, json) in
            
            var articles = [Article]()
            
            let decoder = JSONDecoder()
            do {
                let mostPopularData = try decoder.decode(MostPopularData.self, from: data!)
                articles = mostPopularData.articles
                print(articles)
            } catch {
                print(error)
            }
            
            success(articles, 20)
        }) { (error) in
            failure(error)
        }
    }
}
