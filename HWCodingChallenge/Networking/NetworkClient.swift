//
//  NetworkClient.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

protocol NetworkClient {
    
    func send<T: Decodable>(_ request: URLRequest) async throws -> T
    
}
