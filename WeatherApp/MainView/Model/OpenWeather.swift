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
