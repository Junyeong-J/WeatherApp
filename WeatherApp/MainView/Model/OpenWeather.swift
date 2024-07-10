//
//  OpenWeather.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import Foundation

struct OpenWeather: Decodable {
    let weather: [Weather]
    let main: MainWeather
    let name: String
    
    func celsius(temp: Double) -> String {
        let result = String(format: "%.1f°C", temp - 273.15)
        return result
    }
    
    func maxMinTemp() -> String {
        let result = "최고: \(celsius(temp: main.temp_max)) | 최저: \(celsius(temp: main.temp_min))"
        return result
    }
}

struct MainWeather: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
