//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by 전준영 on 7/12/24.
//

import Foundation
import Alamofire

enum WeatherRequest {
    
    case MainCityWeather(lat: Double, lon: Double)
    case ThreeHourWeather(lat: Double, lon: Double)
    
    var baseURL: String {
        return APIURL.openWeatherBaseURL
    }
    
    var endPoint: URL {
        switch self {
        case .MainCityWeather:
            return URL(string: baseURL + APIURL.openWeatherEndPointURL)!
        case .ThreeHourWeather:
            return URL(string: baseURL + APIURL.threeHourWeatherEndPointURL)!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .MainCityWeather(let lat, let lon), .ThreeHourWeather(let lat, let lon):
            return ["lat": lat,
                    "lon": lon,
                    "lang": "kr",
                    "units": "metric",
                    "appid": APIKey.openWeatherID]
        }
    }
}
