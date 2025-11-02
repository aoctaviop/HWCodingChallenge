//
//  NetworkClientStub.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 1/11/25.
//

import Foundation

@testable import HWCodingChallenge

final class NetworkClientStub {

    @MainActor
    static func make(_ news: [Article]? = nil) throws -> NetworkClient {
        let mockNews = News(
            articles: news ?? [],
            totalResults: news?.count ?? 0
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(mockNews)

        URLProtocolStub.stub = (
            data: data,
            response: HTTPURLResponse(
                url:
                    NewsAPI
                    .topHeadlines(category: .general, page: 0)
                    .generateURL()!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]

        let stubbedSession = URLSession(configuration: config)
        let client = URLSessionNetworkClient(session: stubbedSession)

        return client
    }

}
