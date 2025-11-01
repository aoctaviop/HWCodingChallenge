//
//  NewsAPI.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

enum NewsAPI {
    
    case topHeadlines(category: Category?)
    
}

extension NewsAPI: Endpoint {
    
    static let apiKey: String = "364043d3c33a4b52a3ad5dadb9bee163"
    
    enum Parameters {
        static let category = "category"
        static let page = "page"
        static let pageSize = "pageSize"
        static let country = "country"
    }
    
    var scheme: String {
        "https"
    }
    
    var baseURL: String {
        "newsapi.org"
    }
    
    var path: String {
        "/v2/top-headlines"
    }
    
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = [
            URLQueryItem(
                name: "apiKey",
                value: NewsAPI.apiKey
            )
        ]
        
        switch self {
        case .topHeadlines(let category):
            if let category = category, category != .all {
                items.append(
                    URLQueryItem(
                        name: Parameters.category,
                        value: category.rawValue
                    ),
                )
            }
            items.append(contentsOf: [
                URLQueryItem(
                    name: Parameters.country,
                    value: "us"
                ),
            ]
            )
        }
        
        return items
    }
    
    var method: String {
        "get"
    }
    
    func generateURL() -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
    
    func generateURLRequest() throws -> URLRequest {
        guard let url = generateURL() else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        return request
    }
    
}
