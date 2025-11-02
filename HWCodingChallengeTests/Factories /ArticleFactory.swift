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
        case missingURLToImage
        case missingContent
    }

    static func make(
        _ type: ArticleType,
        author: String? = nil,
        title: String = "This is a title",
        description: String = "This is a description",
        url: String = "https://abcnews.go.com/",
        imageURL: String = "https://example.com/image.jpg",
        date: Date? = nil,
        content: String = "This is some content"
    ) -> Article {
        let author = type == .missingAuthor ? nil : author
        let description = type == .missingDescription ? nil : description
        let urlToImage = type == .missingURLToImage ? nil : imageURL
        let content = type == .missingContent ? nil : content

        let article = Article(
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: date == nil ? .now : date!,
            content: content
        )

        return article
    }

}
