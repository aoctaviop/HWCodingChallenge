//
//  NewsViewModelTests.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 1/11/25.
//

import XCTest

@testable import HWCodingChallenge

final class NewsViewModelTests: XCTestCase {
    
    @MainActor
    func testNewsViewModel_FetchNewsRetrievesNews() async throws {
        let news: [Article] = [
            ArticleFactory.make(title: "Firs Title"),
            ArticleFactory.make(title: "Second Title"),
        ]
        
        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make(news)
            )
        )
        
        try? await viewModel.fetchNews()
        
        XCTAssertEqual(viewModel.articles.count, news.count)
    }
    
}
