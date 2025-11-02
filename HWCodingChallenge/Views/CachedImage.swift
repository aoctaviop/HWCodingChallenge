//
//  CachedImage.swift
//  HWCodingChallenge
//
//  Created by Octavio on 1/11/25.
//

import SwiftUI

struct CachedImage: View {

    private let url: URL?

    @State private var image: Image? = nil
    @State private var isFetching = false

    public init(url: URL?) {
        self.url = url
    }

    var body: some View {
        if let image = image {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        } else {
            ProgressView()
                .onAppear {
                    fetchImage()
                }
        }
    }

    private func fetchImage() {
        Task {
            guard let url = url, !isFetching else { return }

            isFetching = true

            let request = URLRequest(url: url)

            // Check if there's cache for the request
            if let cachedResponse = URLCache.shared.cachedResponse(
                for: request
            ),
                let cachedImage = UIImage(data: cachedResponse.data)
            {
                // Running on main since it's updating UI
                await MainActor.run {
                    self.image = Image(uiImage: cachedImage)
                    self.isFetching = false
                }
                return
            }

            do {
                let (data, response) = try await URLSession.shared.data(
                    for: request
                )

                let cachedData = CachedURLResponse(
                    response: response,
                    data: data
                )

                // Stores request response data in cache
                URLCache.shared.storeCachedResponse(cachedData, for: request)

                if let uiImage = UIImage(data: data) {
                    // Running on main since it's updating UI
                    await MainActor.run {
                        self.image = Image(uiImage: uiImage)
                        self.isFetching = false
                    }
                }
            } catch {
                await MainActor.run {
                    self.isFetching = false
                }
            }
        }
    }

}

#Preview {
    CachedImage(
        url: URL(
            string:
                "https://assets.bwbx.io/images/users/iqjWHBFdfxIU/iUmZZ2Z_Xl8U/v1/1200x800.jpg"
        )
    )
}
