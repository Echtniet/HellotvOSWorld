//
//  StopDTO.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

struct StopDTO: Codable {
    var kind: String
    var estimatedTimeOfDeparture: String?
    var destinationID: Int?
    var destinationName: String
    var destinationCountry: String
    var location: LocationDTO
    var date: String
    var eta: String?
    var etd: String?
}
