//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import UIKit
import SnapKit
import MapKit

final class MainWeatherViewController: BaseViewController {
    
    let ETCTypes: [ETCType] = [.windSpeed, .cloudAmount, .airBarometric, .humidity]
    let viewModel = MainViewModel()
    let mainView = MainWeatherView()
    var threeHourWeatherList: ThreeHourWeather?
    
    let locationManager = CLLocationManager()
    
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
        mainView.threeHourCollectionView.dataSource = self
        mainView.threeHourCollectionView.delegate = self
        mainView.threeHourCollectionView.register(MainThreeCollectionViewCell.self, forCellWithReuseIdentifier: MainThreeCollectionViewCell.identifier)
        
        mainView.etcCollectionView.dataSource = self
        mainView.etcCollectionView.delegate = self
        mainView.etcCollectionView.register(EtcCollectionViewCell.self, forCellWithReuseIdentifier: EtcCollectionViewCell.identifier)
        
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
            self.mainView.etcCollectionView.reloadData()
        }
        
        viewModel.outputThreeWeatherData.bind { _ in
            self.mainView.threeHourCollectionView.reloadData()
            self.mainView.fiveDayTableView.reloadData()
        }
        
        viewModel.outputFiveDayWeatherData.bind { _ in
            self.mainView.fiveDayTableView.reloadData()
        }
        
        viewModel.outputLocationData.bind { weather in
            guard let weather = weather else {return}
            let center = CLLocationCoordinate2D(latitude: weather.lat, longitude: weather.lon)
            self.mainView.mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 200000, longitudinalMeters: 200000)
            let annotation = MKPointAnnotation()
            annotation.coordinate = .init(latitude: weather.lat, longitude: weather.lon)
            self.mainView.mapView.addAnnotation(annotation)
        }
    }
    
    @objc private func mapClicked() {
        let vc = MapViewController()
        vc.locationData = { latitude, longitude in
            print(latitude, longitude)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func listClicked() {
        let vc = CityViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.threeHourCollectionView {
            return viewModel.outputThreeWeatherData.value?.list.count ?? 0
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.threeHourCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainThreeCollectionViewCell.identifier, for: indexPath) as! MainThreeCollectionViewCell
            cell.backgroundColor = #colorLiteral(red: 0.8895074725, green: 0.8895074725, blue: 0.8895074725, alpha: 0.6526127433)
            if let data = viewModel.outputThreeWeatherData.value?.list[indexPath.item] {
                cell.configureData(data: data)
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EtcCollectionViewCell.identifier, for: indexPath) as! EtcCollectionViewCell
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            if let weather = viewModel.outputWeathertData.value {
                cell.configureData(data: ETCTypes[indexPath.row], weather: weather)
            }
            return cell
        }
    }
    
    
}

extension MainWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainFiveDayTableViewCell.identifier, for: indexPath) as! MainFiveDayTableViewCell
        
        if indexPath.row < viewModel.outputFiveDayWeatherData.value.count {
            let data = viewModel.outputFiveDayWeatherData.value[indexPath.row]
            cell.configureData(data: data)
        }
        
        return cell
    }
    
    
}
