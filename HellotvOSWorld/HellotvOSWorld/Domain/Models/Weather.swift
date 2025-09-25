//
//  Untitled.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import Foundation

struct Weather: Equatable, Hashable  {
    let id: Int
    let main: String
    let description: String
    let icon: String

    init(dto: WeatherDTO) {
        self.id = dto.id
        self.main = dto.main
        self.description = dto.description
        self.icon = dto.icon
    }
}
