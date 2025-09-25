//
//  ItineraryDTO.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

struct ItineraryDTO: Codable {
    let id: String
    let title: String
    let status: String
    let startDate: String
    let endDate: String
    let days: [DayDTO]
    let visibility: String
    let duration: Int
    let processing: Bool
    let guestGroupID: String?
    let createdAt: String
    let updatedAt: String
}
