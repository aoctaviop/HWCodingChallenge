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
            articles: news ?? [
                Article(
                    author: "John Smith",
                    title: "This is the first title",
                    description: "This is some description",
                    url: "https://abcnews.go.com/",
                    urlToImage:
                        "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iUmZZ2Z_Xl8U/v1/1200x800.jpg",
                    publishedAt: .now,
                    content: "This is some content"
                ),
                Article(
                    author: "John Smith",
                    title: "This is the second title",
                    description: "This is some description",
                    url: "https://abcnews.go.com/",
                    urlToImage:
                        "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iUmZZ2Z_Xl8U/v1/1200x800.jpg",
                    publishedAt: .now,
                    content: "This is some content"
                ),
            ],
            totalResults: 2
        )

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(mockNews)

        URLProtocolStub.stub = (
            data: data,
            response: HTTPURLResponse(
                url:
                    NewsAPI
                    .topHeadlines(category: .general)
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
