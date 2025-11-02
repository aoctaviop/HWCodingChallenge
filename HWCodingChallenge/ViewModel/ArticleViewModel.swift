//
//  ArticleViewModel.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

struct ArticleViewModel {
    
    private let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
    
    func getAuthor() -> String {
        guard let author = article.author else {
            return "Unknown Author"
        }
        
        return "By \(author)"
    }
    
    func getTitle() -> String {
        article.title
    }
    
    func getDescription() -> String {
        return article.description ?? ""
    }
    
    func getArticleURL() -> URL? {
        URL(string: article.url)
    }
    
    func hasImageURL() -> Bool {
        article.urlToImage != nil
    }
    
    func getImageURl() -> URL? {
        guard let urlToImage = article.urlToImage else { return nil }
        return URL(string: urlToImage)
    }
    
    func getDatePublished() -> String {
        "Published on \(article.publishedAt.formatted(date: .abbreviated, time: .shortened))"
    }
    
    func getContent() -> String {
        article.content ?? ""
    }
    
}
