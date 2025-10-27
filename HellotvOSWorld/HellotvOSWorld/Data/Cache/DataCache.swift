//
//  DataCache.swift
//  HellotvOSWorld
//
//  Created by Clinton on 22/09/2025.
//

import Foundation

actor DataCache<T> {
    private var cache: T?

    func get() -> T? { cache }
    func set(_ value: T) { cache = value }
    func clear() { cache = nil }
}


final class LegacyDataCache<T> {
    private var cache: T?
    private let queue = DispatchQueue(label: "LegacyDataCache.queue", qos: .background)

    func get() -> T? {
        queue.sync { cache }
    }

    func set(_ value: T) {
        queue.sync { cache = value }
    }

    func clear() {
        queue.sync { cache = nil }
    }
}
