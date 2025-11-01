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
    
    func getTitle() -> String {
        article.title
    }
    
    func getDescription() -> String {
        return article.description ?? ""
    }
    
}
