//
//  ArticleFactory.swift
//  HWCodingChallengeTests
//
//  Created by Octavio on 1/11/25.
//

import Foundation

@testable import HWCodingChallenge

struct ArticleFactory {
    
    static func make(title: String = "This is a title") -> Article {
        let author = "John Smith"
        let description = "This is the description"
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
