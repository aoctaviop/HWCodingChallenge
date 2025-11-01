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

    @State private var showProgressView: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(
                        viewModel.articles.enumerated(),
                        id: \.offset
                    ) { _, article in
                        let articleViewModel = ArticleViewModel(article)
                        ArticleView(
                            viewModel: articleViewModel,
                            destinatioView: {
                                ArticleDetailview(
                                    viewModel: articleViewModel
                                )
                            }
                        )
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color(.systemBackground))
                if showProgressView {
                    ProgressView()
                        .progressViewStyle(
                            CircularProgressViewStyle(tint: .blue)
                        )
                        .scaleEffect(2.0, anchor: .center)
                } else if let errorMessage = errorMessage {
                    ContentUnavailableView(
                        errorMessage,
                        systemImage: "exclamationmark.bubble"
                    )
                } else if viewModel.articles.isEmpty {
                    ContentUnavailableView(
                        "No news to show",
                        systemImage: "list.bullet"
                    )
                }
            }
        }
        .onAppear {
            loadNews()
        }
    }

    private func loadNews() {
        Task {
            showProgressView.toggle()
            do {
                try await viewModel.fetchNews()
                showProgressView.toggle()
            } catch let error as NetworkError {
                switch error {
                case .decodingError(_):
                    errorMessage = "Data formatting issue."
                case .serverError(let statusCode):
                    errorMessage = "Server error: \(statusCode)."
                default:
                    errorMessage = "Something went wrong."
                }
                showProgressView.toggle()
            } catch {
                errorMessage =
                    "An unexpected error occurred. \(error.localizedDescription)"
                showProgressView.toggle()
            }
        }
    }
}

#Preview {
    NewsListView()
}
