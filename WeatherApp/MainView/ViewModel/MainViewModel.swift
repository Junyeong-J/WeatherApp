//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import Foundation

final class MainViewModel {
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputWeathertData: Observable<OpenWeather?> = Observable(nil)
    var outputThreeWeatherData: Observable<ThreeHourWeather?> = Observable(nil)
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            self.callRequest()
        }
    }
    
    private func callRequest() {
        WeatherAPIManager.shared.mainWeatherRequest(api: .MainCityWeather(lat: 35.133331, lon: 128.699997), model: Weather.self, completionHandler: { weather, error in
            self.outputWeathertData.value = weather
        })
        
        WeatherAPIManager.shared.fetchThreeHourWeatherAPI { value in
            self.outputThreeWeatherData.value = value
        }
    }
}
