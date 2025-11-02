//
//  ArticleFactory.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 1/11/25.
//

import Foundation

@testable import HWCodingChallenge

struct ArticleFactory {

    enum ArticleType {
        case full
        case missingAuthor
        case missingDescription
        case missingContent
    }

    static func make(
        _ type: ArticleType,
        author: String? = nil,
        title: String = "This is a title",
        description: String = "This is a description",
        date: Date? = nil,
        content: String = "This is some content"
    ) -> Article {
        let author = type == .missingAuthor ? nil : author
        let description = type == .missingDescription ? nil : description
        let urlToImage = "https://example.com/image.jpg"
        let content = type == .missingContent ? nil : content

        let article = Article(
            author: author,
            title: title,
            description: description,
            url: "https://abcnews.go.com/",
            urlToImage: urlToImage,
            publishedAt: date == nil ? .now : date!,
            content: content
        )

        return article
    }

}
