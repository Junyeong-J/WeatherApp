//
//  ETCType.swift
//  WeatherApp
//
//  Created by 전준영 on 7/14/24.
//

import Foundation

enum ETCType: String {
    
    case windSpeed = "바람 속도"
    case cloudAmount = "구름"
    case airBarometric = "기압"
    case humidity = "습도"
    
    func setInfo(weather: OpenWeather) -> String {
        switch self {
        case .windSpeed:
            return "\(weather.wind.speed) m/s"
        case .cloudAmount:
            return "\(weather.clouds.all) %"
        case .airBarometric:
            return "\(weather.main.pressure) hPa"
        case .humidity:
            return "\(weather.main.humidity) %"
        }
    }
    
}
