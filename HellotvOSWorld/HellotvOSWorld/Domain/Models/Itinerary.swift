//
//  Itinerary.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import Foundation

struct Itinerary: Equatable, Hashable  {
    let id: String
    let title: String
    //enum if I knew all status
    let status: String
    let startDate: Date
    let endDate: Date
    let days: [Day]
    let visibility: String
    let duration: Int
    let processing: Bool
    let guestGroupID: String?
    let createdAt: Date
    let updatedAt: Date

    init(dto: ItineraryDTO) {
        self.id = dto.id
        self.title = dto.title
        self.status = dto.status
        self.startDate = Date()
        self.endDate = Date()
        self.days = dto.days.map { Day(dto: $0) }
        self.visibility = dto.visibility
        self.duration = dto.duration
        self.processing = dto.processing
        self.guestGroupID = dto.guestGroupID
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
