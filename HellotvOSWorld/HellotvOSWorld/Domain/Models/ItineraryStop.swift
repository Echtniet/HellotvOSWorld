//
//  ItineraryStop.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import CoreLocation

struct ItineraryStop: Equatable, Hashable  {
    let kind: String
    let estimatedTimeOfDeparture: Date?
    let destinationID: Int?
    let destinationName: String
    let destinationCountry: String
    let location: CLLocation
    let date: Date
    let eta: String?
    let etd: String?

    init(dto: StopDTO) {
        self.kind = dto.kind
        self.estimatedTimeOfDeparture = Date()
        self.destinationID = dto.destinationID
        self.destinationName = dto.destinationName
        self.destinationCountry = dto.destinationCountry
        self.location = CLLocation(coordinate: .init(latitude: dto.location.latitude, longitude: dto.location.longitude), altitude: dto.location.altitude, horizontalAccuracy: .zero, verticalAccuracy: .zero, timestamp: .now)
        self.date = Date()
        self.eta = dto.eta
        self.etd = dto.etd
    }
}
