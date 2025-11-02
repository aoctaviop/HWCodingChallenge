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
    func testArticleViewModel_GetAuthorReturnsUnknownAuthorWhenNil()
        async throws
    {
        let viewModel = ArticleViewModel(ArticleFactory.make(.missingAuthor))

        let formattedAuthor = viewModel.getAuthor()

        XCTAssertEqual(formattedAuthor, "Unknown Author")
    }

    @MainActor
    func testArticleViewModel_GetAuthorReturnsFormattedAuthorWhenNotNil()
        async throws
    {
        let author = "John Smith"
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.full, author: author)
        )

        let formattedAuthor = viewModel.getAuthor()

        XCTAssertEqual(formattedAuthor, "By \(author)")
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

    @MainActor
    func testArticleViewModel_GetDateReturnsRightStringFormattedDate()
        async throws
    {
        let date: Date = .now
        let expectedFormattedDate =
            "Published on \(date.formatted(date: .abbreviated, time: .shortened))"

        let viewModel = ArticleViewModel(
            ArticleFactory.make(.full)
        )

        let formattedDate = viewModel.getDatePublished()

        XCTAssertEqual(formattedDate, expectedFormattedDate)
    }

    @MainActor
    func testArticleViewModel_GetContentReturnsContentWhenNotNil() async throws
    {
        let content = "This is some content"
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.full, content: content)
        )

        XCTAssertEqual(viewModel.getContent(), content)
    }

    @MainActor
    func testArticleViewModel_GetContentReturnsEmptyStringWhenContentNil()
        async throws
    {
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.missingContent)
        )

        XCTAssertEqual(viewModel.getContent(), "")
    }

    @MainActor
    func testArticleViewModel_HasImageURLReturnsTrueWhenNotNil() async throws {
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.full)
        )

        XCTAssertTrue(viewModel.hasImageURL())
    }

    @MainActor
    func testArticleViewModel_HasImageURLReturnsFalseWhenNil() async throws {
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.missingURLToImage)
        )

        XCTAssertFalse(viewModel.hasImageURL())
    }

    @MainActor
    func testArticleViewModel_GetImageURLReturnsURLWhenNotNil() async throws {
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.full, imageURL: "http://www.imageurl.com")
        )

        XCTAssertEqual(
            viewModel.getImageURL(),
            URL(string: "http://www.imageurl.com")
        )
    }

    @MainActor
    func testArticleViewModel_GetImageURLReturnsNilWhenNil() async throws {
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.missingURLToImage)
        )

        XCTAssertNil(viewModel.getImageURL())
    }

    @MainActor
    func testArticleViewModel_GetArticleURLReturnsURLWhenValidURL() async throws
    {
        let viewModel = ArticleViewModel(
            ArticleFactory.make(.full, url: "https://abcnews.go.com/")
        )

        XCTAssertEqual(
            viewModel.getArticleURL(),
            URL(string: "https://abcnews.go.com/")
        )
    }

}
