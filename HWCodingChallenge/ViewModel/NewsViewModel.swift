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
                ) ?? Category.general.rawValue
        ) ?? .general
    {
        didSet {
            UserDefaults.standard
                .set(category.rawValue, forKey: Constants.Keys.category)
        }
    }

    private let newsService: NewsService

    private var fetchedArticles: [Article] = []

    private var totalResults: Int = 0
    private var totalPages: Int = 0
    private var currentPage: Int = 1

    init(newsService: NewsService) {
        self.newsService = newsService
    }

    func reset() {
        fetchedArticles.removeAll()
        articles.removeAll()
        
        totalResults = 0
        totalPages = 0
        currentPage = 1
    }

    @MainActor
    func fetchNews() async throws {
        let news =
            try await newsService
            .fetchNews(category: category, page: currentPage)

        fetchedArticles.append(contentsOf: news.articles)

        articles = fetchedArticles
        totalResults = news.totalResults
        totalPages = Int(ceil(Double(totalResults) / 15.0))
        
        print(
            "***\(articles.count) resullts out of \(totalResults), page \(currentPage) out of \(totalPages)"
        )
    }

    func isShowingGeneralFeed() -> Bool {
        category == .general
    }

    func filterNews(_ searchText: String) {
        if !searchText.isEmpty {
            articles =
                fetchedArticles
                .filter(
                    {
                        $0.title.lowercased().contains(searchText.lowercased())
                    })
        } else {
            articles = fetchedArticles
        }
    }

    func checkPagination(itemIndex: Int) async {
        print("Last loaded item: \(itemIndex)")

        if itemIndex == articles.count - 1, currentPage < totalPages {
            currentPage += 1
            print("Current page \(currentPage)")
            try? await fetchNews()
        }
    }
    
    func getPaginationText() -> String? {
        guard !fetchedArticles.isEmpty && totalResults > 0 else {
            return nil
        }
        return "Showing \(fetchedArticles.count) out of \(totalResults)"
    }

}
