//
//  CityDTO.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

struct CityDTO: Codable {
    let id: Int
    let name: String
    let coord: CoordDTO
    let country: String
    let population: Int
    let timezone: Int
}
