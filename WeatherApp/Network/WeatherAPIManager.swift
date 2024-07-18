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
    
    typealias WeatherHandler<T: Decodable> = (Result<T, OpenWeatherError>) -> Void
    
    func openWeatherRequest<T: Decodable>(api: WeatherRequest, model: T.Type, completionHandler: @escaping WeatherHandler<T>) {
        AF.request(api.endPoint, method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString)
        )
        .validate(statusCode: 200..<500)
        .responseDecodable(of: model) { response in
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                completionHandler(.failure(.failedRequest))
                print(error)
            }
        }
    }
    
}
