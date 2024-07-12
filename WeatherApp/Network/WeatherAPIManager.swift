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
    
    typealias OpenWeatherHandler = (OpenWeather?, OpenWeatherError?) -> Void
    
    func mainWeatherRequest<T: Decodable>(api: WeatherRequest, model: T.Type, completionHandler: @escaping OpenWeatherHandler) {
        AF.request(api.endPoint, method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString)
        )
        .validate(statusCode: 200..<500)
        .responseDecodable(of: OpenWeather.self) { response in
            switch response.result{
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, .failedRequest)
                print(error)
            }
        }
    }
    
    
    
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
