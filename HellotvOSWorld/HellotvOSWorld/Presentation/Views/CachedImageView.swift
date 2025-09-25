//
//  CachedImageView.swift
//  HellotvOSWorld
//
//  Created by Clinton on 24/09/2025.
//

import SwiftUI

struct CachedImageView: View, Equatable {
    @State private var viewModel: CachedImageViewModel
    let url: URL
    let blurry: Bool

    init(url: URL, blurry: Bool = false, viewModel: CachedImageViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
        self.url = url
        self.blurry = blurry
    }

    var body: some View {
        VStack {
            if let image = viewModel.image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                    if blurry {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .blur(radius: blurry ? 5 : 0)
                            .mask(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: .clear, location: 0.4),
                                        .init(color: .black, location: 0.6),
                                        .init(color: .black, location: 1.0)
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                    }
                }
            } else if viewModel.isloading {
                //TODO: Make nice image loading
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
        .onAppear {
            Task {
                try await viewModel.loadImage(for: url)
            }
        }
    }
}

extension CachedImageView {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.url == rhs.url
    }
}
