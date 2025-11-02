//
//  NetworkErrorTests.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 2/11/25.
//

import Foundation
import Testing

@testable import HWCodingChallenge

struct NetworkErrorTests {

    @Test(
        arguments: [
            NetworkError.invalidURL,
            NetworkError.invalidResponse,
            NetworkError.decodingError(NSError.init(domain: "", code: 0) as Error),
            NetworkError.serverError(statusCode: 0, errorMessage: nil),
            NetworkError.noData,
            NetworkError.underlying(NSError.init(domain: "", code: 0) as Error),
        ]
    )
    func NetworkError_ComparingExactSameErrorsReturnTrue(error: NetworkError)
        async throws
    {
        let copyError = error
        #expect(error == copyError)
    }

    @Test
    func NetworkError_ServerErrorAsosciatedError() async throws {
        let option = NetworkError.serverError(statusCode: 0, errorMessage: nil)

        if case .serverError(let statusCode, let errorMessage) = option {
            #expect(statusCode == 0 && errorMessage == nil)
        }
    }

}
