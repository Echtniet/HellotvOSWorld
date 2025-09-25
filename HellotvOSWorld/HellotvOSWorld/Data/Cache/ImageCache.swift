//
//  ImageCache.swift
//  HellotvOSWorld
//
//  Created by Clinton on 24/09/2025.
//

import Foundation
import SwiftUI

actor ImageCache {
    private let memoryCache = NSCache<NSString, UIImage>()
    private let fileManager = FileManager.default
    private let diskCacheURL: URL

    init() {
        let cacheDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        diskCacheURL = cacheDir.appendingPathComponent("ImageCache")

        if !fileManager.fileExists(atPath: diskCacheURL.path) {
            try? fileManager.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
        }
    }

    func getImage(forKey key: String) async -> UIImage? {
        if let memoryImage = memoryCache.object(forKey: key as NSString) {
            return memoryImage
        }
        
        let diskPath = diskCacheURL.appendingPathComponent(key)
        if let data = try? Data(contentsOf: diskPath), let cachedImage = UIImage(data: data) {
            memoryCache.setObject(cachedImage, forKey: key as NSString)
            return cachedImage
        }

        return nil
    }

    func setImage(_ image: UIImage, forKey key: String) {
        memoryCache.setObject(image, forKey: key as NSString)
        let diskPath = diskCacheURL.appendingPathComponent(key)
        if let data = image.pngData() {
            try? data.write(to: diskPath)
        }
    }
}
