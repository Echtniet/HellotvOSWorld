//
//  DashboardDTO.swift
//  HellotvOSWorld
//
//  Created by Clinton on 21/09/2025.
//

struct DashboardDTO: Codable {
    let welcomeWithUser: String
    let welcomeWithoutUser: String
    let background: String
    let useMap: Bool
    let widgets: [DashboardWidgetDTO]
}
