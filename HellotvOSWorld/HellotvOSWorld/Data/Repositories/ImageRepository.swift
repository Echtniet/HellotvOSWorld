//
//  ImageRepository.swift
//  HellotvOSWorld
//
//  Created by Clinton on 24/09/2025.
//

import UIKit

protocol ImageRepositoryProtocol {
    func fetchImage(from url: URL, forcedRefresh: Bool) async throws -> UIImage
}

class ImageRepository: ImageRepositoryProtocol {

    private let cache: ImageCache

    private var onGoingTask: [URL: Task<UIImage, Error>] = [:]

    init(cache: ImageCache) {
        self.cache = cache
    }

    func fetchImage(from url: URL, forcedRefresh: Bool) async throws -> UIImage {
        let key = url.lastPathComponent

        if !forcedRefresh {
            if let cachedImage = await cache.getImage(forKey: key) {
                return cachedImage
            }

            if let task = onGoingTask[url] {
                return try await task.value
            }
        } else {
            onGoingTask[url]?.cancel()
        }

        let task = Task<UIImage, Error> {
            defer { onGoingTask[url] = nil }
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                throw URLError(.badServerResponse)
            }

            await cache.setImage(image, forKey: key)
            return image
        }

        onGoingTask[url] = task
        return try await task.value
    }

}
