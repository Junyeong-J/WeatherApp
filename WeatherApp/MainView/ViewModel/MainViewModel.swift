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
    var midnightWeatherData: Observable<[FiveDayData]> = Observable([]) // 00시 데이터를 위한 Observable
    
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
        
        WeatherAPIManager.shared.fetchThreeHourWeatherAPI(api: .ThreeHourWeather(lat: lat, lon: lon), model: WeatherList.self, completionHandler: { weather, error in
            self.outputThreeWeatherData.value = weather
            self.extractMidnightWeatherData()
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
        
        midnightWeatherData.value = fiveDayData
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
