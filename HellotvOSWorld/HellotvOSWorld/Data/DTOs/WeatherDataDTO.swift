//
//  WeatherDataDTO.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

struct WeatherDataDTO: Codable {
    let date: String
    let sunrise: String
    let sunset: String
    let temp: TempDTO
    let feelsLike: FeelsLikeDTO
    let pressure: Int
    let humidity: Int
    let weather: [WeatherDTO]
    let speed: Double
    let deg: Int
    let gust: Double
    let clouds: Int
    let pop: Double
    let rain: Double?

    enum CodingKeys: String, CodingKey {
        case date, sunrise, sunset, temp, feelsLike = "feels_like", pressure, humidity, weather, speed, deg, gust, clouds, pop, rain
    }
}
