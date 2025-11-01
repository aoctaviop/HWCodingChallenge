//
//  ArticleDetailView.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import SwiftUI

struct ArticleView<ArticleDetailView: View>: View {
    
    var viewModel: ArticleViewModel
    
    @ViewBuilder let destinatioView: ArticleDetailView
    
    var body: some View {
        NavigationLink {
            destinatioView
        } label: {
            VStack {
                Text(viewModel.getTitle())
                    .font(.headline)
                Text(viewModel.getDescription())
                    .font(.subheadline)
            }
            .padding()
        }
    }
}

#Preview {
    let article: Article = .init(
        author: "",
        title: "",
        description: "",
        url: "",
        urlToImage: "",
        publishedAt: .now,
        content: ""
    )
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

