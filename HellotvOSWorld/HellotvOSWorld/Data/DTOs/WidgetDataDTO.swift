//
//  WidgetDataDTO.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

struct WidgetDataDTO: Codable {
    var city: CityDTO? = nil
    var cod: String? = nil
    var message: Double? = nil
    var cnt: Int? = nil
    var list: [WeatherDataDTO]? = nil

    var lastStop: StopDTO? = nil
    var currentStop: StopDTO? = nil
    var nextStop: StopDTO? = nil
    var currentStopIsFirst: Bool? = nil
    var currentStopIsLast: Bool? = nil
    var distanceMetersCurrentToNext: Int? = nil
    var timeMinutesCurrentToNext: Int? = nil
    var timeMinustesYachtToNext: Int? = nil
    var timePercentageYachtToNext: Int? = nil
    var activeItinerary: ItineraryDTO? = nil

    var latitude: Double? = nil
    var longitude: Double? = nil
    var altitude: Double? = nil
    var id: String? = nil
    var dateTime: String? = nil
    var date: String? = nil
    var time: String? = nil
    var location: String? = nil
    var title: String? = nil
    var description: String? = nil
    var timezone: String? = nil
    var kind: String? = nil
    var createdAt: String? = nil
    var updatedAt: String? = nil
    var extraInfo: StopDTO? = nil

    var position: PositionDTO? = nil
    var heading: Double? = nil

    var wifiSsid: String? = nil
    var wifiPassword: String? = nil

    enum CodingKeys: String, CodingKey {
        case city, cod, message, cnt, list
        case lastStop, currentStop, nextStop, currentStopIsFirst, currentStopIsLast, distanceMetersCurrentToNext, timeMinutesCurrentToNext, timeMinustesYachtToNext, timePercentageYachtToNext, activeItinerary
        case latitude, longitude, altitude, id = "_id", dateTime, date, time, location, title, description, timezone, kind, createdAt, updatedAt, extraInfo
        case position, heading
        case wifiSsid, wifiPassword
    }
}
