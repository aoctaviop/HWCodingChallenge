//
//  NetworkError.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

enum NetworkError: Error, Equatable {
    
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case serverError(statusCode: Int)
    case noData
    case underlying(Error)
    
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidResponse, .invalidResponse):
            return true
        case (.decodingError(_), .decodingError(_)):
            return true
        case (.serverError(let lhsCode), .serverError(let rhsCode)):
            return lhsCode == rhsCode
        case (.noData, .noData):
            return true
        case (.underlying(_), .underlying(_)):
            return true
        default:
            return false
        }
    }
    
}
