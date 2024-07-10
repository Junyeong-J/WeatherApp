//
//  WeatherAPIManager.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import Foundation
import Alamofire

final class WeatherAPIManager {
    
    static let shared = WeatherAPIManager()
    
    private init() { }
    
    func fetchWeatherAPI(completionHandler: @escaping (OpenWeather) -> Void) {
        let url = "\(APIURL.openWeatherURL)\(APIKey.openWeatherID)"
        
        AF.request(url).responseDecodable(of: OpenWeather.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchThreeHourWeatherAPI(completionHandler: @escaping (ThreeHourWeather) -> Void) {
        let url = "\(APIURL.threeHourWeatherURL)\(APIKey.openWeatherID)"
        
        AF.request(url).responseDecodable(of: ThreeHourWeather.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
