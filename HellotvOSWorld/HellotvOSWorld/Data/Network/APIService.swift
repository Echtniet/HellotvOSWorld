//
//  APIService.swift
//  HellotvOSWorld
//
//  Created by Clinton on 21/09/2025.
//

import Foundation

protocol APIServiceProtocol {
    func fetchDashboard(for name: String, lastname: String, forcedRefresh: Bool) async throws -> DashboardDTO
}

class APIService: APIServiceProtocol {
    private var baseURLString = "https://collector-demo.superyachtapi.com/resources/dashboard?name="

    private static var ongoingTask: [String: Task<DashboardDTO, Error>] = [:]

    func fetchDashboard(for name: String, lastname: String, forcedRefresh: Bool) async throws -> DashboardDTO {

        let key = "dashboard"

        if let task = Self.ongoingTask[key], !forcedRefresh {
            return try await task.value
        }

        Self.ongoingTask[key]?.cancel()

        let task = Task { () -> DashboardDTO in
            defer { Self.ongoingTask[key] = nil }

            let urlString = baseURLString + "\(name)+\(lastname)"

            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }

            let (data, _) = try await URLSession.shared.data(from: url)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            return try JSONDecoder().decode(DashboardDTO.self, from: data)

        }

        Self.ongoingTask[key] = task
        return try await task.value
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


