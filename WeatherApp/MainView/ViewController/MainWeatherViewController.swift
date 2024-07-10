//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import UIKit
import SnapKit

final class MainWeatherViewController: BaseViewController {
    
    let cityNameLabel = UILabel()
    let temperatureLabel = UILabel()
    let weatherInformationLabel = UILabel()
    let highAndLowLabel = UILabel()
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func configureHierarchy() {
        view.addSubview(cityNameLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(weatherInformationLabel)
        view.addSubview(highAndLowLabel)
    }
    
    override func configureConstraints() {
        cityNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(cityNameLabel.snp.bottom).offset(2)
        }
        
        weatherInformationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(temperatureLabel.snp.bottom).offset(2)
        }
        
        highAndLowLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(weatherInformationLabel.snp.bottom).offset(2)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}

extension MainWeatherViewController {
    func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputWeathertData.bind { weather in
            if let cityName = weather?.name, let temp = weather?.main.temp,
               let detailWeather = weather?.weather.first?.main,
               let tempMin = weather?.main.temp_min, let tempMax = weather?.main.temp_max{
                self.cityNameLabel.text = "\(cityName)"
                self.temperatureLabel.text = "\(temp)"
                self.weatherInformationLabel.text = "\(detailWeather)"
                self.highAndLowLabel.text = "\(tempMin)|\(tempMax)"
            }
        }
    }
}
