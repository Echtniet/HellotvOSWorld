//
//  APIService.swift
//  HellotvOSWorld
//
//  Created by Clinton on 21/09/2025.
//

import Foundation

enum APIVersion: String {
    case apiServiceV1
    case apiServiceV2
}

actor TaskCache {
    private var cache: [String: Any] = [:]

    func get<T>(for key: String) -> Task<T, Error>? {
        cache[key] as? Task<T, Error>
    }

    func set<T>(_ task: Task<T, Error>?, for key: String) {
        cache[key] = task
    }

    func remove(for key: String) {
        cache[key] = nil
    }
}

protocol APIServiceProtocol {
    func fetchDashboard(for name: String, lastname: String, forcedRefresh: Bool) async throws -> DashboardDTO
}

class APIService: APIServiceProtocol {
    private var baseURLString = "https://collector-demo.superyachtapi.com/resources/dashboard?name="

    private let taskCache: TaskCache

    init(taskCache: TaskCache) {
        self.taskCache = taskCache
    }

    private func request<T: Codable>(url: URL, cacheKey: String, forcedRefresh: Bool = false) async throws -> T {
        if let exsistingTask: Task<T, Error> = await taskCache.get(for: cacheKey), !forcedRefresh {
            return try await exsistingTask.value
        }

        let newTask = Task { () -> T in
            defer { Task { await taskCache.remove(for: cacheKey) } }
            do {
                guard !Task.isCancelled else {
                    throw CancellationError()
                }
                let (data, _) = try await URLSession.shared.data(from: url)
                return try JSONDecoder().decode(T.self, from: data)
            } catch is CancellationError {
                if let retryTask: Task<T, Error> = await taskCache.get(for: cacheKey) {
                    return try await retryTask.value
                }
                throw CancellationError()
            }
        }

        let oldTask: Task<T, Error>? = await taskCache.get(for: cacheKey)
        await taskCache.set(newTask, for: cacheKey)

        if forcedRefresh { oldTask?.cancel() }

        return try await newTask.value
    }

    func fetchDashboard(for name: String, lastname: String, forcedRefresh: Bool) async throws -> DashboardDTO {

        let key = "dashboard"

        let urlString = baseURLString + "\(name)+\(lastname)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        return try await request(url: url, cacheKey: key, forcedRefresh: forcedRefresh)
    }
}

class MockAPIService: APIServiceProtocol {
    func fetchDashboard(for name: String, lastname: String, forcedRefresh: Bool) async throws -> DashboardDTO {
        return DashboardDTO(
            welcomeWithUser: "Welcome Clinton Davelaar, enjoy your stay!",
            welcomeWithoutUser: "Welcome onboard, enjoy your stay!",
            background: "https://api1.superyachtapi.com/api/yachteye/customers/stream-file/https%3A%2F%2Fcdn.yachteye.com%2Fyachts%2FY028000000%2Fphoto%2FDemoYacht_Anchored.jpg",
            useMap: false,
            widgets: [
                .init(
                    kind: "weather",
                    data: .init()
                ),
                .init(
                    kind: "itinerary",
                    data: .init(
                        lastStop: .init(
                            kind: "",
                            destinationName: "Nice, France",
                            destinationCountry: "7 JUN",
                            location: .init(latitude: 0, longitude: 0, altitude: 0),
                            date: ""
                        ), currentStop: .init(
                            kind: "",
                            destinationName: "Monaco",
                            destinationCountry: "🇲🇨 Monaco",
                            location: .init(latitude: 0, longitude: 0, altitude: 0),
                            date: ""
                        ),
                        nextStop: .init(
                            kind: "",
                            destinationName: "Nice, France",
                            destinationCountry: "7 JUN",
                            location: .init(latitude: 0, longitude: 0, altitude: 0),
                            date: ""
                        ),
                        activeItinerary: .init(
                            id: "",
                            title: "",
                            status: "",
                            startDate: "",
                            endDate: "",
                            days: [],
                            visibility: "",
                            duration: 0,
                            processing: false,
                            guestGroupID: nil,
                            createdAt: "",
                            updatedAt: ""
                        )
                    )
                ),
                .init(
                    kind: "schedule",
                    data: .init(
                        extraInfo: .init(
                            kind: "",
                            destinationName: "Nice, France",
                            destinationCountry: "7 JUN",
                            location: .init(latitude: 0, longitude: 0, altitude: 0),
                            date: ""
                        )
                    )
                 ),
                .init(
                    kind: "weather",
                    data: .init()
                ),
                .init(
                    kind: "itinerary",
                    data: .init(
                        lastStop: .init(
                            kind: "",
                            destinationName: "Nice, France",
                            destinationCountry: "7 JUN",
                            location: .init(latitude: 0, longitude: 0, altitude: 0),
                            date: ""
                        ), currentStop: .init(
                            kind: "",
                            destinationName: "Monaco",
                            destinationCountry: "🇲🇨 Monaco",
                            location: .init(latitude: 0, longitude: 0, altitude: 0),
                            date: ""
                        ),
                        nextStop: .init(
                            kind: "",
                            destinationName: "Nice, France",
                            destinationCountry: "7 JUN",
                            location: .init(latitude: 0, longitude: 0, altitude: 0),
                            date: ""
                        ),
                        activeItinerary: .init(
                            id: "",
                            title: "",
                            status: "",
                            startDate: "",
                            endDate: "",
                            days: [],
                            visibility: "",
                            duration: 0,
                            processing: false,
                            guestGroupID: nil,
                            createdAt: "",
                            updatedAt: ""
                        )
                    )
                ),
                .init(
                    kind: "schedule",
                    data: .init(
                        extraInfo: .init(
                            kind: "",
                            destinationName: "Nice, France",
                            destinationCountry: "7 JUN",
                            location: .init(latitude: 0, longitude: 0, altitude: 0),
                            date: ""
                        )
                    )
                 ),
            ]
        )
    }
}
