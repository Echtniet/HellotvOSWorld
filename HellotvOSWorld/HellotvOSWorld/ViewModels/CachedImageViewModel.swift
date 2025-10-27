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
        Task(priority: .background) {
            await MainActor.run {
                isloading = true
            }
            defer { Task { await MainActor.run { isloading = false } } }

            do {
                let image = try await repository.fetchImage(from: url, forcedRefresh: !firstLoad)
                await MainActor.run {
                    self.image = image
                }
            } catch {
                print("Failed to load image for url: \(url) with error: \(error)")
                errorMessage = "Failed to load image"
            }
        }
    }
}
