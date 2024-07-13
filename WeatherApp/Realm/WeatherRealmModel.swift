//
//  WeatherRealmModel.swift
//  WeatherApp
//
//  Created by 전준영 on 7/13/24.
//

import Foundation
import RealmSwift

class WeatherData: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var lat: Double
    @Persisted var lon: Double
    @Persisted var regdate: Date
    
    convenience init(name: String, lat: Double, lon: Double) {
        self.init()
        self.name = name
        self.lat = lat
        self.lon = lon
    }
}
