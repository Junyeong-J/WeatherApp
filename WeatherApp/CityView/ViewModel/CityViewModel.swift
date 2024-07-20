//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by 전준영 on 7/12/24.
//

import Foundation

final class CityViewModel {
    
    private let repository = WeatherRepository.shared
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputSearchText: Observable<String?> = Observable(nil)
    var inputCellSelected: Observable<CityList?> = Observable(nil)
    
    var outputCityData: Observable<[CityList]> = Observable([])
    var outputFilterCityData: Observable<[CityList]> = Observable([])
    
    
    init() {
        print("CityViewModel init")
        transform()
    }
    
    deinit {
        print("CityViewModel Deinit")
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.callCityRequest()
        }
        
        inputSearchText.bind { [weak self] _ in
            self?.filterSearchCityName()
        }
        
        inputCellSelected.bind { [weak self] weather in
            guard let weather = weather else {return}
            self?.saveWeather(cityname: weather.name, lat: weather.coord.lat, lon: weather.coord.lon)
        }
    }
    
    private func callCityRequest() {
        guard let path = Bundle.main.path(forResource: "CityList", ofType: "json") else {
            return
        }
        guard let jsonString = try? String(contentsOfFile: path) else {
            return
        }
        
        let decoder = JSONDecoder()
        let data = jsonString.data(using: .utf8)
        if let data = data {
            do {
                let cityList = try decoder.decode([CityList].self, from: data)
                self.outputCityData.value = cityList
                self.outputFilterCityData.value = cityList
            } catch {
                print("Decoding error: \(error)")
            }
        }
    }
    
    private func filterSearchCityName() {
        guard let searchText = inputSearchText.value, !searchText.isEmpty else {
            outputFilterCityData.value = outputCityData.value
            return
        }
        
        outputFilterCityData.value = outputCityData.value.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
        
    }
    
    private func saveWeather(cityname: String, lat: Double, lon: Double) {
        repository.detectRealmURL()
        repository.createOrUpdateItem(cityName: cityname, lat: lat, lon: lon)
    }
    
}
