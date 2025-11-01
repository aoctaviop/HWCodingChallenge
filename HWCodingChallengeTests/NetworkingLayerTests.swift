//
//  NetworkingLayerTests.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 1/11/25.
//

import XCTest

@testable import HWCodingChallenge

final class NetworkingLayerTests: XCTestCase {

    @MainActor
    func testFetchNews_ReturnsDecodedNews() async throws {
        let mockNews = News(
            articles: [
                ArticleFactory.make(.full, title: "This is a title")
            ]
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

        let service = NewsService(networkClient: client)

        let news = try await service.fetchNews(category: .general)

        XCTAssertEqual(news.articles.first?.title, "This is a title")
    }

    @MainActor
    func testFetchNews_ServerError() async throws {
        URLProtocolStub.stub = (
            data: nil,
            response: HTTPURLResponse(
                url: NewsAPI.topHeadlines(category: .general).generateURL()!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            ),
            error: nil
        )

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]

        let stubbedSession = URLSession(configuration: config)
        let client = URLSessionNetworkClient(session: stubbedSession)

        let service = NewsService(networkClient: client)

        do {
            _ = try await service.fetchNews(category: .general)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertEqual(
                error as? NetworkError,
                .serverError(statusCode: 500)
            )
        }
    }

    @MainActor
    func testFetchNews_DecodingError() async throws {
        URLProtocolStub.stub = (
            data: "{}".data(using: .utf8)!,
            response: HTTPURLResponse(
                url: NewsAPI.topHeadlines(category: .general).generateURL()!,
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

        let service = NewsService(networkClient: client)

        do {
            _ = try await service.fetchNews(category: .general)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertEqual(
                error as? NetworkError,
                .decodingError(NSError() as Error)
            )
        }
    }

    @MainActor
    func testFetchNews_NoData() async throws {
        URLProtocolStub.stub = (
            data: "".data(using: .utf8),
            response: HTTPURLResponse(
                url: NewsAPI.topHeadlines(category: .general).generateURL()!,
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

        let service = NewsService(networkClient: client)

        do {
            _ = try await service.fetchNews(category: .general)
            XCTFail("Expected an error but got success")
        } catch {
            XCTAssertEqual(
                error as? NetworkError,
                .noData
            )
        }
    }

}
