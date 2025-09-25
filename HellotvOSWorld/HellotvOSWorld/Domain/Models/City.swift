//
//  City.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import CoreLocation

struct City: Equatable, Hashable  {
    let id: Int
    let name: String
    let location: CLLocation
    let country: String
    let population: Int
    let timezone: Int

    init(dto: CityDTO?) {
        guard let dto else {
            //TODO: handle properly
            print("CityDTO is nil")
            self.id = 0
            self.name = ""
            self.location = CLLocation(latitude: 0, longitude: 0)
            self.country = ""
            self.population = 0
            self.timezone = 0
            return
        }

        self.id = dto.id
        self.name = dto.name
        self.location = CLLocation(latitude: dto.coord.lat, longitude: dto.coord.lon)
        self.country = dto.country
        self.population = dto.population
        self.timezone = dto.timezone
    }
}
