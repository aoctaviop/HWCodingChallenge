//
//  NewsListView.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import SwiftUI

struct NewsListView: View {
    
    @StateObject private var viewModel: NewsViewModel = NewsViewModel(
        newsService: NewsService(networkClient: URLSessionNetworkClient())
    )
    
    var body: some View {
        NavigationView {
            List(viewModel.articles, id: \.title) { article in
                let articleViewModel = ArticleViewModel(article)
                ArticleView(viewModel: articleViewModel) {
                    ArticleDetailview(viewModel: articleViewModel)
                }
            }
            .onAppear {
                Task {
                    try? await viewModel.fetchNews()
                }
            }
        }
    }
}

#Preview {
    NewsListView()
}
