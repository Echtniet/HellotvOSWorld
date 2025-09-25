//
//  WeatherData.swift
//  HellotvOSWorld
//
//  Created by Clinton on 25/09/2025.
//

import Foundation

struct WeatherData: Equatable, Hashable  {

    let date: Date
    let sunrise: String
    let sunset: String
    let temperature: Temperature
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let weather: [Weather]
    let speed: Double
    let deg: Int
    let gust: Double
    let clouds: Int
    let pop: Double
    let rain: Double?

    init(dto: WeatherDataDTO) {
        //string to date
        self.date = Date()
        self.sunrise = dto.sunrise
        self.sunset = dto.sunset
        self.temperature = Temperature(dto: dto.temp)
        self.feelsLike = FeelsLike(dto: dto.feelsLike)
        self.pressure = dto.pressure
        self.humidity = dto.humidity
        self.weather = dto.weather.map { Weather(dto: $0) }
        self.speed = dto.speed
        self.deg = dto.deg
        self.gust = dto.gust
        self.clouds = dto.clouds
        self.pop = dto.pop
        self.rain = dto.rain
    }
}
