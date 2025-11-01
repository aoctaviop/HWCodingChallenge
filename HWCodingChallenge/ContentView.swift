//
//  ContentView.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: NewsViewModel = NewsViewModel(
        newsService: NewsService(networkClient: URLSessionNetworkClient())
    )
    
    var body: some View {
        List(viewModel.articles, id: \.title) { article in
            Text(article.title)
        }
        .onAppear {
            Task {
                try? await viewModel.fetchNews()
            }
        }
    }
}

#Preview {
    ContentView()
}
