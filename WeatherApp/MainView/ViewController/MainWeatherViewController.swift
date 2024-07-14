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
        setupToolBarButton()
        bindData()
        
        configureCollectionView()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func setupToolBarButton() {
        navigationController?.isToolbarHidden = false
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let map = UIBarButtonItem(image: UIImage(systemName: "map")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(mapClicked))
        let cityList = UIBarButtonItem(image: UIImage(systemName: "list.bullet")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(listClicked))
        let barItems = [map, flexibleSpace, flexibleSpace, flexibleSpace, cityList]
        self.toolbarItems = barItems
    }
    
    private func configureCollectionView() {
        mainView.threeHourCollecrtionView.dataSource = self
        mainView.threeHourCollecrtionView.delegate = self
        mainView.threeHourCollecrtionView.register(MainThreeCollectionViewCell.self, forCellWithReuseIdentifier: MainThreeCollectionViewCell.identifier)
    }
    
    private func configureTableView() {
        mainView.fiveDayTableView.rowHeight = 60
        mainView.fiveDayTableView.dataSource = self
        mainView.fiveDayTableView.delegate = self
        mainView.fiveDayTableView.register(MainFiveDayTableViewCell.self, forCellReuseIdentifier: MainFiveDayTableViewCell.identifier)
    }
    
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
        
        viewModel.outputThreeWeatherData.bind { _ in
            self.mainView.threeHourCollecrtionView.reloadData()
        }
        
    }
    
    @objc private func mapClicked() {
        
    }
    
    @objc private func listClicked() {
        let vc = CityViewController()
        navigationController?.pushViewController(vc, animated: true)
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

extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainFiveDayTableViewCell.identifier, for: indexPath) as! MainFiveDayTableViewCell
        
        return cell
    }
    
    
}
