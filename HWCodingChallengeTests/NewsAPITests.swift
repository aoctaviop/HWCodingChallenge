//
//  NewsAPITests.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 2/11/25.
//

import Foundation
import Testing

@testable import HWCodingChallenge

struct NewsAPITests {

    @MainActor
    @Test
    func NewsAPI_SchemeReturnsExpectedValue() async throws {
        #expect(NewsAPI.topHeadlines(category: nil, page: 0).scheme == "https")
    }

    @MainActor
    @Test
    func NewsAPI_BaseURLReturnsExpectedValue() async throws {
        #expect(
            NewsAPI.topHeadlines(category: nil, page: 0).baseURL
                == "newsapi.org"
        )
    }

    @MainActor
    @Test(arguments: [NewsAPI.topHeadlines(category: nil, page: 0)])
    func NewsAPI_PathReturnsExpectedValue(item: NewsAPI) async throws {
        var expectedPath = ""

        switch item {
        case .topHeadlines(category: _, page: _):
            expectedPath = "/v2/top-headlines"
        }

        #expect(
            item.path == expectedPath
        )
    }

    @Test(arguments: [
        "Business", "Entertaiment", "Health", "Science", "Sports", "Technology",
    ])
    func NewsAPI_QueryItemsContainExpectedValuesWhenACategoryIsSelected(
        category: String
    ) async throws {
        let expectedQueryItems = [
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "page", value: "0"),
            URLQueryItem(name: "pageSize", value: "15"),
            URLQueryItem(name: "country", value: "us"),
        ]

        let queryItems =
            await NewsAPI
            .topHeadlines(
                category: .init(rawValue: category),
                page: 0
            ).queryItems

        #expect(Set(queryItems).isSuperset(of: Set(expectedQueryItems)))
    }

    @Test
    func NewsAPI_QueryItemsDoNotContainCategoryWhenGeneralIsSelected()
        async throws
    {
        let queryItems =
            await NewsAPI
            .topHeadlines(
                category: .general,
                page: 0
            ).queryItems

        #expect(
            !queryItems.contains(where: { item in
                item.name == "category"
            })
        )
    }

    @MainActor
    @Test(arguments: [NewsAPI.topHeadlines(category: nil, page: 0)])
    func NewsAPI_MethodturnsExpectedValue(item: NewsAPI) async throws {
        var expectedMethod = ""

        switch item {
        case .topHeadlines(category: _, page: _):
            expectedMethod = "get"
        }

        #expect(
            item.method == expectedMethod
        )
    }

}
