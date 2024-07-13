//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by 전준영 on 7/13/24.
//

import Foundation
import RealmSwift

final class WeatherRepository {
    
    private let realm = try! Realm()
    
    func createOrUpdateItem(cityName: String, lat: Double, lon: Double) {
        do {
            try realm.write {
                if let existItem = realm.objects(WeatherData.self).first {
                    existItem.name = cityName
                    existItem.lat = lat
                    existItem.lon = lon
                    print("realm update succeed")
                } else {
                    let item = WeatherData(name: cityName, lat: lat, lon: lon)
                    realm.add(item)
                    print("realm Create Succeed")
                }
            }
        } catch {
            print(error)
        }
    }
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
    func fetchData() -> WeatherData? {
        return realm.objects(WeatherData.self).first
    }
    
}
