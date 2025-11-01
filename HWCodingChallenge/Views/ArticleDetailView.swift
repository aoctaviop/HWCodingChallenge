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
        NavigationView {
            Text(viewModel.getDescription())
                .padding()
                .navigationBarTitle(Text(viewModel.getTitle()))
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
