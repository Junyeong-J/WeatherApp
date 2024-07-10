//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import UIKit
import SnapKit

final class MainWeatherViewController: BaseViewController {
    
    let viewModel = MainViewModel()
    
    let mainView = MainWeatherView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureConstraints() {
        
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
               let detailWeather = weather?.weather.first?.main {
                self.mainView.cityNameLabel.text = "\(cityName)"
                self.mainView.temperatureLabel.text = weather?.celsius(temp: temp)
                self.mainView.weatherInformationLabel.text = "\(detailWeather)"
                self.mainView.highAndLowLabel.text = weather?.maxMinTemp()
            }
        }
    }
}
