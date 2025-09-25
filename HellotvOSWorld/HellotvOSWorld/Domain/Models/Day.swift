//
//  Day.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import Foundation

struct Day: Equatable, Hashable  {
    let dayNumber: Int
    let kind: String
    let date: Date
    let stationary: Bool
    let cruising: Bool
    let stops: [ItineraryStop]

    init(dto: DayDTO) {
        self.dayNumber = dto.dayNumber
        self.kind = dto.kind
        self.date = Date()
        self.stationary = dto.stationary
        self.cruising = dto.cruising
        self.stops = dto.stops.map { ItineraryStop(dto: $0) }
    }
}
