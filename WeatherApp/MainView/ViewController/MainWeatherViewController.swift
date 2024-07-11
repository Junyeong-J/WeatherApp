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
    
    var threeHourWeatherList: ThreeHourWeather?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        
        mainView.threeHourCollecrtionView.dataSource = self
        mainView.threeHourCollecrtionView.delegate = self
        mainView.threeHourCollecrtionView.register(MainThreeCollectionViewCell.self, forCellWithReuseIdentifier: MainThreeCollectionViewCell.identifier)
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
    private func bindData() {
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
        
        viewModel.outputThreeWeatherData.bind { value in
            self.mainView.threeHourCollecrtionView.reloadData()
        }
        
    }
}

extension MainWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputThreeWeatherData.value?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainThreeCollectionViewCell.identifier, for: indexPath) as! MainThreeCollectionViewCell
        if let data = viewModel.outputThreeWeatherData.value?.list[indexPath.item] {
            cell.configureData(data: data)
        }
        return cell
    }
    
    
}
