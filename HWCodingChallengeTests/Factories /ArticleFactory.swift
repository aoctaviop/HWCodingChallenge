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
        case missingDescription
    }

    static func make(
        _ type: ArticleType,
        title: String = "This is a title",
        description: String = "This is a description"
    ) -> Article {
        let author = "John Smith"
        let description = type == .missingDescription ? nil : description
        let urlToImage = "https://example.com/image.jpg"
        let content = "This is some content"

        let article = Article(
            author: author,
            title: title,
            description: description,
            url: "https://abcnews.go.com/",
            urlToImage: urlToImage,
            publishedAt: .now,
            content: content
        )

        return article
    }

}
