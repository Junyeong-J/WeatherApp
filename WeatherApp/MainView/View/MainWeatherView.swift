//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by 전준영 on 7/11/24.
//

import UIKit
import SnapKit

final class MainWeatherView: BaseView {
    
    let cityNameLabel = UILabel()
    let temperatureLabel = UILabel()
    let weatherInformationLabel = UILabel()
    let highAndLowLabel = UILabel()
    
    
    override func configureHierarchy() {
        addSubview(cityNameLabel)
        addSubview(temperatureLabel)
        addSubview(weatherInformationLabel)
        addSubview(highAndLowLabel)
    }
    
    override func configureLayout() {
        cityNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(cityNameLabel.snp.bottom).offset(1)
        }
        
        weatherInformationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(1)
        }
        
        highAndLowLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(weatherInformationLabel.snp.bottom).offset(1)
        }
    }
    
    override func configureView() {
        cityNameLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 40), cornerRadius: 0, numberLine: 0)
        temperatureLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 70), cornerRadius: 0, numberLine: 0)
        weatherInformationLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 30), cornerRadius: 0, numberLine: 0)
        highAndLowLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 20), cornerRadius: 0, numberLine: 0)
    }
    
}
