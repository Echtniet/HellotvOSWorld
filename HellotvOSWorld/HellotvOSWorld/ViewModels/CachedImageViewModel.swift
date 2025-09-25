//
//  CacheImageViewModel.swift
//  HellotvOSWorld
//
//  Created by Clinton on 24/09/2025.
//

import Combine
import Foundation
import Observation
import UIKit

@Observable
@MainActor
class CachedImageViewModel {
    var image: UIImage?
    var isloading: Bool = false
    var errorMessage: String?

    @ObservationIgnored private var firstLoad: Bool = true

    @ObservationIgnored private let repository: ImageRepositoryProtocol

    init(repository: ImageRepositoryProtocol) {
        self.repository = repository
    }

    func loadImage(for url: URL) async throws {
        Task {
            isloading = true
            defer { isloading = false }

            do {
                let image = try await repository.fetchImage(from: url, forcedRefresh: !firstLoad)
                self.image = image
            } catch {
                print("Failed to load image for url: \(url) with error: \(error)")
                errorMessage = "Failed to load image"
            }
        }
    }
}
