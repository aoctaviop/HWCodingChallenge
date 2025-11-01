//
//  NewsViewModel.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Combine
import Foundation

class NewsViewModel: ObservableObject {

    @Published var articles: [Article] = []
    @Published var category: Category =
    Category(
        rawValue: UserDefaults.standard
            .string(
                forKey: Constants.Keys.category
            ) ?? Category.all.rawValue
    ) ?? .all
    {
        didSet {
            UserDefaults.standard
                .set(category.rawValue, forKey: Constants.Keys.category)
        }
    }

    private let newsService: NewsService

    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func reset() {
        articles.removeAll()
    }

    @MainActor
    func fetchNews() async throws {
        let news =
            try await newsService
            .fetchNews(category: category)

        articles.append(contentsOf: news.articles)

        print(articles.count)
    }

}
