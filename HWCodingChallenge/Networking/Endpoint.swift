//
//  Endpoint.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

protocol Endpoint {
    
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var method: String { get }
    func generateURL() -> URL?
    func generateURLRequest() throws -> URLRequest
    
}
