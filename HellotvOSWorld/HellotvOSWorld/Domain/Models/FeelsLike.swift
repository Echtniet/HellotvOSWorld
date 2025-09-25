//
//  FeelsLike.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import Foundation

struct FeelsLike: Equatable, Hashable  {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double

    init(dto: FeelsLikeDTO) {
        self.day = dto.day
        self.night = dto.night
        self.eve = dto.eve
        self.morn = dto.morn
    }
}
