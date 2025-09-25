//
//  DayDTO.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

struct DayDTO: Codable {
    let dayNumber: Int
    let kind: String
    let date: String
    let stationary: Bool
    let cruising: Bool
    let stops: [StopDTO]
}
