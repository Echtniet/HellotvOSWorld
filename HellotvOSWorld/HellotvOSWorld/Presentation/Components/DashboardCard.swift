//
//  DashboardCard.swift
//  HellotvOSWorld
//
//  Created by Clinton on 24/09/2025.
//

import SwiftUI
/*
    Seems to be a werid missmatch with the data there is no destination kind but seems like itinerary is meant to be used for both destination and schedule cards
    Both are missing weather data regardless and there is no image for either
 */
struct DashboardCard: View, Equatable {

    let model: DashboardWidget

    var body: some View {
        switch model {
        case .weather:
            WeatherCard()
        case .itinerary:
            DestinationCard(model: model)
        case .schedule:
            ItineraryCard()
        case .map:
            MapCard()
        case .wifi:
            EmptyView()
        case .unknown:
            EmptyView()
        }
    }
}
