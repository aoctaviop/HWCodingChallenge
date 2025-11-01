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
            ArticleFactory.make(.full, title: "Firs Title"),
            ArticleFactory.make(.full, title: "Second Title"),
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
        testNewsViewModel_ShowingGeneralFeedShouldBeTrueWhenAllCategoryIsSelected()
        async throws
    {
        let viewModel = NewsViewModel(
            newsService: NewsService(
                networkClient: try NetworkClientStub.make()
            )
        )

        XCTAssertTrue(viewModel.isShowingGeneralFeed())
    }

    override func tearDown() {
        super.tearDown()

        UserDefaults.standard.removeObject(forKey: Constants.Keys.category)
    }

}
