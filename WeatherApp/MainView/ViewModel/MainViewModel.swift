//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import Foundation

final class MainViewModel {
    
    private let repository = WeatherRepository.shared
    
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputMyLocation: Observable<[Double]?> = Observable(nil)
    
    var outputWeathertData: Observable<OpenWeather?> = Observable(nil)
    var outputThreeWeatherData: Observable<ThreeHourWeather?> = Observable(nil)
    var outputFiveDayWeatherData: Observable<[FiveDayData]> = Observable([])
    var outputLocationData: Observable<WeatherData?> = Observable(nil)
    
    init() {
        print("MainViewModel init")
        transform()
    }
    
    deinit {
        print("MainViewModel Deinit")
    }
    
    private func transform() {
        inputViewDidLoadTrigger.bind { [weak self] _ in
            self?.callRequest()
            self?.locationMap()
        }
        
        inputMyLocation.bind { [weak self] coordinates in
            guard let coordinates = coordinates, coordinates.count == 2 else { return }
            let lat = coordinates[0]
            let lon = coordinates[1]
            self?.saveMyLocation(lat: lat, lon: lon)
        }
    }
    
    private func callRequest() {
        let defaultLat = 37.654165
        let defaultLon = 127.049696
        
        let weatherData = repository.fetchData()
        let lat = weatherData?.lat ?? defaultLat
        let lon = weatherData?.lon ?? defaultLon
        
        WeatherAPIManager.shared.mainWeatherRequest(api: .MainCityWeather(lat: lat, lon: lon), model: Weather.self, completionHandler: { [weak self] result in
            switch result {
            case .success(let weather):
                self?.outputWeathertData.value = weather
            case .failure(let error):
                print(error)
            }
            
        })
        
        WeatherAPIManager.shared.fetchThreeHourWeatherAPI(api: .ThreeHourWeather(lat: lat, lon: lon), model: WeatherList.self, completionHandler: { [weak self] result in
            switch result {
            case .success(let weather):
                self?.outputThreeWeatherData.value = weather
                self?.extractMidnightWeatherData()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func extractMidnightWeatherData() {
        guard let weatherList = outputThreeWeatherData.value?.list else {
            return
        }
        
        let calendar = Calendar.current
        var dayData: [String: [WeatherList]] = [:]
        
        for item in weatherList {
            let date = Date(timeIntervalSince1970: TimeInterval(item.dt))//Unix 타임스탬프를 Date 객체로 변환
            let dateString = calendar.dateComponents([.year, .month, .day], from: date).formattedDateString()//문자열로 변환
            
            dayData[dateString, default: []].append(item)//각 데이터를 날짜별로 그룹화
        }
        
        let sortedDayData = dayData.sorted(by: { $0.key < $1.key })//날짜별로 정렬
        
        var fiveDayData: [FiveDayData] = []
        
        for (key, value) in sortedDayData.prefix(5) {
            let minTemp = value.min(by: { $0.main.temp_min < $1.main.temp_min })?.main.temp_min ?? 0.0 //전후로 비교하면서 가장 작은값 가져오기
            let maxTemp = value.max(by: { $0.main.temp_max < $1.main.temp_max })?.main.temp_max ?? 0.0 //전후로 비교하면서 가장 큰값 가져오기
            let icon = value.flatMap { $0.weather.map { $0.icon } }.mostFrequent() ?? "" // 각 아이콘이름중 빈번한걸로 저장
            
            let date = value.first?.dt_txt ?? key // 잘짜는 해당날짜로 저장
            
            let fiveDayItem = FiveDayData(minTemp: minTemp, maxTemp: maxTemp, icon: icon, dt: date) //저장할 값
            fiveDayData.append(fiveDayItem)// 담기
        }
        
        outputFiveDayWeatherData.value = fiveDayData
    }
    
    private func locationMap() {
        var weatherData = repository.fetchData()
        if weatherData == nil {
            weatherData = WeatherData(name: "", lat: 37.654165, lon: 127.049696)
            outputLocationData.value = weatherData
        } else {
            outputLocationData.value = weatherData
        }
    }
    
    private func saveMyLocation(lat: Double, lon: Double) {
        repository.createOrUpdateItem(cityName: "MyLocation", lat: lat, lon: lon)
        var weatherData = repository.fetchData()
        if weatherData == nil {
            weatherData = WeatherData(name: "", lat: 37.654165, lon: 127.049696)
            outputLocationData.value = weatherData
        } else {
            outputLocationData.value = weatherData
        }
    }
    
}

extension Array where Element: Hashable {
    func mostFrequent() -> Element? {
        let counts = self.reduce(into: [:]) { counts, element in
            counts[element, default: 0] += 1
        }
        return counts.max(by: { $0.value < $1.value })?.key
    }
}

private extension DateComponents {
    func formattedDateString() -> String {
        guard let year = year, let month = month, let day = day else { return "" }
        return String(format: "%04d-%02d-%02d", year, month, day)
    }
}
