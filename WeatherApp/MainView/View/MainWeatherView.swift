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
            make.top.equalTo(cityNameLabel.snp.bottom).offset(2)
        }
        
        weatherInformationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(2)
        }
        
        highAndLowLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(weatherInformationLabel.snp.bottom).offset(2)
        }
    }
    
    override func configureView() {
        
    }
    
}
