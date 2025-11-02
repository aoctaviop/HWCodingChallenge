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
    func testNewsViewModel_ChangeCategorySavesNewSelectedCategory() async throws
    {
        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make()
            )
        )

        viewModel.category = .science

        let savedCategory =
            UserDefaults.standard.string(forKey: Constants.Keys.category) ?? ""

        XCTAssertEqual(Category.science.rawValue, savedCategory)
    }

    @MainActor
    func testNewsViewModel_FetchNewsRetrievesNews() async throws {
        let news: [Article] = [
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
        ]

        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make(news)
            )
        )

        try? await viewModel.fetchNews()

        XCTAssertEqual(viewModel.articles.count, news.count)
    }

    @MainActor
    func
        testNewsViewModel_ShowingGeneralFeedShouldBeFalseWhenAnyCategoryIsSelected()
        async throws
    {
        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make()
            )
        )

        viewModel.category = .science

        XCTAssertFalse(viewModel.isShowingGeneralFeed())
    }

    @MainActor
    func
        testNewsViewModel_ShowingGeneralFeedShouldBeTrueWhenGeneralCategoryIsSelected()
        async throws
    {
        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make()
            )
        )

        XCTAssertTrue(viewModel.isShowingGeneralFeed())
    }

    @MainActor
    func
    testNewsViewModel_FilterNewsWithMatchingCriteriaResultShouldMatchCriteria()
    async throws
    {
        let news: [Article] = [
            ArticleFactory.make(.full, title: "This is the first title"),
            ArticleFactory.make(.full, title: "This is the second title"),
        ]
        
        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make(news)
            )
        )
        
        try? await viewModel.fetchNews()
        
        viewModel.filterNews("first")
        
        XCTAssertTrue(viewModel.articles.first!.title.contains("first"))
    }
    
    @MainActor
    func testNewsViewModel_FilterNewsWithNoMatchingCriteriaShouldResultEmpty()
    async throws
    {
        let news: [Article] = [
            ArticleFactory.make(.full, title: "This is the first title"),
            ArticleFactory.make(.full, title: "This is the second title"),
        ]
        
        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make(news)
            )
        )
        
        try? await viewModel.fetchNews()
        
        viewModel.filterNews("third")
        
        XCTAssertTrue(viewModel.articles.isEmpty)
    }
    
    @MainActor
    func testNewsViewModel_GetPaginationTextReturnsStringWhenThereAreResults()
    async throws
    {
        let news: [Article] = [
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
            ArticleFactory.make(.full),
        ]
        
        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make(news)
            )
        )
        
        try? await viewModel.fetchNews()
        
        let totalPages = Int(ceil(Double(news.count) / Double(NewsAPI.pageSize)))
        
        XCTAssertEqual(
            viewModel.getPaginationText(),
            "Page 1 out of \(totalPages)"
        )
    }
    
    @MainActor
    func testNewsViewModel_GetPaginationTextReturnsNilThereAreNoResults()
    async throws
    {
        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make()
            )
        )
        
        try? await viewModel.fetchNews()
        
        XCTAssertNil(viewModel.getPaginationText())
    }
    
    override func tearDown() {
        super.tearDown()

        UserDefaults.standard.removeObject(forKey: Constants.Keys.category)
    }

}
