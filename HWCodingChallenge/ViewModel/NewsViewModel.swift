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

    private let newsService: NewsService

    init(newsService: NewsService) {
        self.newsService = newsService
    }

    @MainActor
    func fetchNews() async throws {
        let news =
            try await newsService
            .fetchNews()

        articles.append(contentsOf: news.articles)

        print(articles.count)
    }

}
