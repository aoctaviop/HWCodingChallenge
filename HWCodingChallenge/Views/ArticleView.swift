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
            ZStack {
                ZStack {
                    if let imageURL = viewModel.getImageURl() {
                        CachedImage(url: imageURL)
                            .frame(minWidth: 150.0)
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    }
                    LinearGradient(
                        colors: [
                            Color(.systemBackground),
                            Color(.systemBackground),
                            Color(.systemBackground),
                            Color(.systemBackground).opacity(0.7),
                            .clear,
                        ],
                        startPoint: .trailing,
                        endPoint: .leading
                    )
                }
                HStack {
                    if viewModel.hasImageURL() {
                        Spacer(minLength: 90.0)
                    }
                    VStack(alignment: .leading) {
                        Text(viewModel.getTitle())
                            .font(.headline)
                            .padding(.bottom, 5)
                            .shadow(
                                color: .init(uiColor: .systemBackground),
                                radius: 5.0
                            )
                        if !viewModel.getDescription().isEmpty {
                            Text(viewModel.getDescription())
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .lineLimit(3)
                        }
                    }
                }
                .padding(.vertical, 10.0)
            }
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
