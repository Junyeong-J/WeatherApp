//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by 전준영 on 7/11/24.
//

import UIKit
import SnapKit

final class MainWeatherView: BaseView {

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let cityNameLabel = UILabel()
    let temperatureLabel = UILabel()
    let weatherInformationLabel = UILabel()
    let highAndLowLabel = UILabel()
    
    let threeHourView = UIView()
    let fiveDayView = UIView()
    let locationView = UIView()
    let etcView = UIView()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherInformationLabel)
        contentView.addSubview(highAndLowLabel)
        contentView.addSubview(threeHourView)
        contentView.addSubview(fiveDayView)
        contentView.addSubview(locationView)
        contentView.addSubview(etcView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(contentView).inset(20)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(cityNameLabel.snp.bottom).offset(1)
        }
        
        weatherInformationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(1)
        }
        
        highAndLowLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(weatherInformationLabel.snp.bottom).offset(1)
        }
        
        threeHourView.snp.makeConstraints { make in
            make.top.equalTo(highAndLowLabel.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(300)
        }
        
        fiveDayView.snp.makeConstraints { make in
            make.top.equalTo(threeHourView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(500)
        }
        
        locationView.snp.makeConstraints { make in
            make.top.equalTo(fiveDayView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(300)
        }
        
        etcView.snp.makeConstraints { make in
            make.top.equalTo(locationView.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(500)
        }
    }
    
    override func configureView() {
        cityNameLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 40), cornerRadius: 0, numberLine: 0)
        temperatureLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 70), cornerRadius: 0, numberLine: 0)
        weatherInformationLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 30), cornerRadius: 0, numberLine: 0)
        highAndLowLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 20), cornerRadius: 0, numberLine: 0)
        
        threeHourView.backgroundColor = .blue
        fiveDayView.backgroundColor = .green
        locationView.backgroundColor = .red
        etcView.backgroundColor = .brown
        
        
    }
    
}
