//
//  DataCache.swift
//  HellotvOSWorld
//
//  Created by Clinton on 22/09/2025.
//

actor DataCache<T> {
    private var cache: T?

    func get() -> T? { cache }
    func set(_ value: T) { cache = value }
    func clear() { cache = nil }
}
