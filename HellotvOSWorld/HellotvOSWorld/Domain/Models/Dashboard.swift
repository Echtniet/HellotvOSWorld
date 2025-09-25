//
//  Dashboard.swift
//  HellotvOSWorld
//
//  Created by Clinton on 21/09/2025.
//

import CoreLocation

struct Dashboard: Equatable, Hashable {
    let welcomeWithUser: String
    let welcomeWithoutUser: String
    let backgroundImage: URL?
    let useMap: Bool
    let widgets: [DashboardWidget]

    init(dto: DashboardDTO) {
        self.welcomeWithUser = dto.welcomeWithUser
        self.welcomeWithoutUser = dto.welcomeWithoutUser
        self.backgroundImage = URL(string: dto.background)
        self.useMap = dto.useMap
        self.widgets = dto.widgets.map { DashboardWidget(dto: $0) }
    }
}
