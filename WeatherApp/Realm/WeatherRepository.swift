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
    
    func createItem(cityName: String, lat: Double, lon: Double) {
        
        let item = WeatherData(name: cityName, lat: lat, lon: lon)
        
        do {
            try realm.write {
                realm.add(item)
                print("realm Create Succeed")
            }
        } catch {
            print(error)
        }
        
    }
    
    func detectRealmURL() {
        print(realm.configuration.fileURL ?? "")
    }
    
}
