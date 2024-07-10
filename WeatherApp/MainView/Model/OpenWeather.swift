//
//  OpenWeather.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import Foundation

//MARK: - 상단 한가지 지역 날씨 정보
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

//MARK: - 5일 3시간 간격으로 정보 조회
struct ThreeHourWeather: Decodable {
    let list: [WeatherList]
    let city: City
    
    struct WeatherList: Decodable {
        let dt: Int
        let main: MainList
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let dt_txt: String
        let rain: Rain?
    }
    
    struct MainList: Decodable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let sea_level: Int?
        let grnd_level: Int?
        let humidity: Int
        let temp_kf: Double
    }
    
    struct Weather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Clouds: Decodable {
        let all: Int
    }
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
        let gust: Double?
    }
    
    struct Rain: Decodable {
        let _3h: Double?
        
        private enum CodingKeys: String, CodingKey {
            case _3h = "3h"
        }
    }
    
    struct City: Decodable {
        let id: Int
        let name: String
        let country: String
    }
}
