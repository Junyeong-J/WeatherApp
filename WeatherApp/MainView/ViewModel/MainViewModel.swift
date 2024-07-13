//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import Foundation

final class MainViewModel {
    
    let repository = WeatherRepository()
    
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
        let defaultLat = 37.654165
        let defaultLon = 127.049696
        
        let weatherData = repository.fetchData()
        let lat = weatherData?.lat ?? defaultLat
        let lon = weatherData?.lon ?? defaultLon
        
        WeatherAPIManager.shared.mainWeatherRequest(api: .MainCityWeather(lat: lat, lon: lon), model: Weather.self, completionHandler: { weather, error in
            self.outputWeathertData.value = weather
        })
        
        WeatherAPIManager.shared.fetchThreeHourWeatherAPI { value in
            self.outputThreeWeatherData.value = value
        }
    }
}
