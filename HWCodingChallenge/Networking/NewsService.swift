//
//  NewsService.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import Foundation

class NewsService {

    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func fetchNews(category: Category, page: Int) async throws -> News {
        let request = try NewsAPI.topHeadlines(category: category, page: page)
            .generateURLRequest()

        return try await networkClient.send(request)
    }

}
