//
//  DashboardWidget.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import CoreLocation

enum DashboardWidget: Equatable, Hashable  {
    case weather(City, String, Double, Int, [WeatherData], UUID)
    case itinerary(ItineraryStop, ItineraryStop, ItineraryStop, Bool, Bool, Int, Int, Int, Int, Itinerary, UUID)
    case schedule(CLLocation, String, Date, Date, String, String, String, String, String, String, Date, Date, ItineraryStop, UUID)
    case map(CLLocation, Double, UUID)
    case wifi(String, String, UUID)
    case unknown(String, UUID)

    init(dto: DashboardWidgetDTO) {
        switch dto.kind {
        case "weather":
            self = .weather(
                City(dto: dto.data.city),
                dto.data.cod ?? "",
                dto.data.message ?? 0.0,
                dto.data.cnt ?? 0,
                dto.data.list?.map { WeatherData(dto: $0) } ?? [],
                UUID()
            )
        case "itinerary":
            self = .itinerary(
                ItineraryStop(dto: dto.data.lastStop!),
                ItineraryStop(dto: dto.data.currentStop!),
                ItineraryStop(dto: dto.data.nextStop!),
                dto.data.currentStopIsFirst ?? false,
                dto.data.currentStopIsLast ?? false,
                dto.data.distanceMetersCurrentToNext ?? 0,
                dto.data.timeMinutesCurrentToNext ?? 0,
                dto.data.timeMinustesYachtToNext ?? 0,
                dto.data.timePercentageYachtToNext ?? 0,
                Itinerary(dto: dto.data.activeItinerary!),
                UUID()
            )

        case "schedule":
            self = .schedule(
                CLLocation(coordinate: .init(latitude: dto.data.latitude ?? 0.0, longitude: dto.data.longitude ?? 0.0), altitude: dto.data.altitude ?? 0.0, horizontalAccuracy: .zero, verticalAccuracy: .zero, timestamp: .now),
                dto.data.id ?? "",
                Date(),
                Date(),
                dto.data.time ?? "",
                dto.data.location ?? "",
                dto.data.title ?? "",
                dto.data.description ?? "",
                dto.data.timezone ?? "",
                dto.data.kind ?? "",
                Date(),
                Date(),
                ItineraryStop(dto: dto.data.extraInfo!),
                UUID()
            )
        case "map":
            self = .map(CLLocation(latitude: dto.data.position?.latitude ?? 0.0, longitude: dto.data.position?.longitude ?? 0.0), dto.data.heading ?? 0.0, UUID())
        case "wifi":
            self = .wifi(dto.data.wifiSsid ?? "", dto.data.wifiPassword ?? "", UUID())
        default:
            self = .unknown(dto.kind, UUID())
        }
    }

    var id: UUID {
        switch self {
        case .weather(_, _, _, _, _, let uuid):
            return uuid
        case .itinerary(_, _, _, _, _, _, _, _, _, _, let uuid):
            return uuid
        case .schedule(_, _, _, _, _, _, _, _, _, _, _, _, _, let uuid):
            return uuid
        case .map(_, _, let uuid):
            return uuid
        case .wifi(_, _, let uuid):
            return uuid
        case .unknown(_, let uuid):
            return uuid
        }
    }
}
