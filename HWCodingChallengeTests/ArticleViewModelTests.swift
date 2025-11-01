//
//  ArticleViewModelTests.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 1/11/25.
//

import XCTest

@testable import HWCodingChallenge

final class ArticleViewModelTests: XCTestCase {

    @MainActor
    func testArticleViewModel_GetTitleReturnsTitle()
        async throws
    {
        let title = "This is a title"
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.full, title: title)
        )

        XCTAssertEqual(viewModel.getTitle(), "This is a title")
    }

    @MainActor
    func testArticleViewModel_GetDescriptionReturnsDescriptionWhenNotNil()
        async throws
    {
        let description = "This is a description"
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.full, description: description)
        )

        XCTAssertEqual(viewModel.getDescription(), description)
    }

    @MainActor
    func testArticleViewModel_GetDescriptionReturnsEmptyStringWhenNil()
        async throws
    {
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.missingDescription)
        )

        XCTAssertEqual(viewModel.getDescription(), "")
    }

}
