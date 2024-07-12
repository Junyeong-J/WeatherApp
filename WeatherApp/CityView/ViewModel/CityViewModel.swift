//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by 전준영 on 7/12/24.
//

import Foundation

final class CityViewModel {
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputCityData: Observable<[CityList]> = Observable([])
    init() {
        transform()
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { _ in
            self.callCityRequest()
        }
    }
    
    private func callRequest() {
        
    }
    
    func callCityRequest() {
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
            } catch {
                print("Decoding error: \(error)")
            }
        }
    }
    
    
}
