//
//  ArticleDetailViewModel.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import SwiftUI

struct ArticleDetailview: View {
    var viewModel: ArticleViewModel

    var body: some View {
        GeometryReader { geometry in
            let maxWidth = geometry.size.width
            let maxHeight = geometry.size.height * 0.4
            let maxImageWidth = UIScreen.main.bounds.size.width
            VStack {
                ZStack(alignment: .bottom) {
                    if let imageURL = viewModel.getImageURL() {
                        CachedImage(url: imageURL)
                            .frame(
                                width: maxImageWidth,
                                height: maxHeight
                            )
                            .clipShape(
                                .rect.size(
                                    CGSize(
                                        width: maxImageWidth,
                                        height: maxHeight
                                    )
                                )
                            )
                            .overlay {
                                LinearGradient(
                                    colors: [
                                        .clear,
                                        Color(.systemBackground),
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            }
                            .ignoresSafeArea()
                    } else {
                        LinearGradient(
                            colors: [
                                .primary,
                                .clear,
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(
                            width: maxWidth,
                            height: maxHeight
                        )
                        .clipShape(
                            .rect.size(
                                CGSize(
                                    width: maxWidth,
                                    height: maxHeight
                                )
                            )
                        )
                        .ignoresSafeArea()
                    }
                    VStack {
                        Text(viewModel.getTitle())
                            .font(.title)
                            .bold()
                            .shadow(
                                color: Color(.systemBackground),
                                radius: 5.0
                            )
                            .padding()
                            .frame(width: maxWidth)
                        Text(viewModel.getAuthor())
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Text(
                            viewModel.getDatePublished()
                        )
                        .font(.caption)
                        .foregroundStyle(.gray)
                    }
                    .padding(.horizontal)
                }
                .frame(
                    width: maxWidth,
                    height: maxHeight
                )
                if !viewModel.getDescription().isEmpty {
                    Text(viewModel.getDescription())
                        .font(.caption)
                        .padding(.horizontal)
                        .padding()
                }
                if !viewModel.getContent().isEmpty {
                    Text(viewModel.getContent())
                        .font(.body)
                        .padding(.horizontal)
                }
                Spacer()
                HStack(alignment: .center) {
                    if let url = viewModel.getArticleURL() {
                        Link(destination: url) {
                            Text("Read full article")
                                .font(.title3)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ArticleDetailview(
        viewModel: ArticleViewModel(
            .init(
                author: "",
                title: "",
                description: "",
                url: "",
                urlToImage: "",
                publishedAt: .now,
                content: ""
            )
        )
    )
}
