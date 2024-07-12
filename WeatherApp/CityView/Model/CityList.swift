//
//  CityList.swift
//  WeatherApp
//
//  Created by 전준영 on 7/12/24.
//

import Foundation

struct CityList: Decodable {
    
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: CityLocation
}

struct CityLocation: Decodable {
    let lon: Double
    let lat: Double
}
