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
    case serverError(statusCode: Int, errorMessage: String?)
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
        case (.serverError(let lhsCode, let lhsMessage), .serverError(let rhsCode, let rhsMessage)):
            return lhsCode == rhsCode && lhsMessage == rhsMessage
        case (.noData, .noData):
            return true
        case (.underlying(_), .underlying(_)):
            return true
        default:
            return false
        }
    }

}
