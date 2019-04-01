//
//  Article.swift
//  NYArticles
//
//  Created by Muhammad Akram on 01/04/19.
//  Copyright © 2019 Muhammad Akram. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Article: Codable {
    let title: String
    let author: String
    let description: String
    let date: String
    let media: [Media]
    
    enum CodingKeys : String, CodingKey {
        case title = "title"
        case author = "byline"
        case description = "abstract"
        case date = "published_date"
        case media = "media"
    }
}

struct MostPopularData: Codable {
    let articles: [Article]
    
    enum CodingKeys : String, CodingKey {
        case articles = "results"
    }
}

struct Media: Codable {
    let metadata: [MediaMetadata]
    
    enum CodingKeys : String, CodingKey {
        case metadata = "media-metadata"
    }
}

struct MediaMetadata: Codable {
    let url: String
}
