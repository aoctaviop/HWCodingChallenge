//
//  URLSessionNetworkClient.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

final class URLSessionNetworkClient: NetworkClient {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func send<T>(_ request: URLRequest) async throws -> T where T: Decodable {
        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            let decoder = JSONDecoder()
            let error: APIError? = try? decoder.decode(
                APIError.self,
                from: data
            )
            throw NetworkError.serverError(
                statusCode: httpResponse.statusCode,
                errorMessage: error?.message
            )
        }

        guard !data.isEmpty else {
            throw NetworkError.noData
        }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }

}
