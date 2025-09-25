//
//  Temperature.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import Foundation

struct Temperature: Equatable, Hashable  {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double

    init(dto: TempDTO) {
        self.day = dto.day
        self.min = dto.min
        self.max = dto.max
        self.night = dto.night
        self.eve = dto.eve
        self.morn = dto.morn
    }
}
