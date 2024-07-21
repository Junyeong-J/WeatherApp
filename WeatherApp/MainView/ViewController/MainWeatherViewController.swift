//
//  MainWeatherViewController.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import UIKit
import SnapKit
import MapKit

final class MainWeatherViewController: BaseViewController<MainWeatherView> {
    
    let ETCTypes: [ETCType] = [.windSpeed, .cloudAmount, .airBarometric, .humidity]
    let viewModel = MainViewModel()
    var threeHourWeatherList: ThreeHourWeather?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolBarButton()
        bindData()
        configureCollectionView()
        configureTableView()
    }
    
    deinit {
        print("MainWeatherViewController Deinit")
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
    
    private func setupToolBarButton() {
        navigationController?.isToolbarHidden = false
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let map = UIBarButtonItem(image: UIImage(systemName: "map")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(mapClicked))
        let cityList = UIBarButtonItem(image: UIImage(systemName: "list.bullet")?.withTintColor(.black, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(listClicked))
        let barItems = [map, flexibleSpace, flexibleSpace, flexibleSpace, cityList]
        self.toolbarItems = barItems
    }
    
    private func configureCollectionView() {
        rootView.threeHourCollectionView.dataSource = self
        rootView.threeHourCollectionView.delegate = self
        rootView.threeHourCollectionView.register(MainThreeCollectionViewCell.self, forCellWithReuseIdentifier: MainThreeCollectionViewCell.identifier)
        
        rootView.etcCollectionView.dataSource = self
        rootView.etcCollectionView.delegate = self
        rootView.etcCollectionView.register(EtcCollectionViewCell.self, forCellWithReuseIdentifier: EtcCollectionViewCell.identifier)
        
    }
    
    private func configureTableView() {
        rootView.fiveDayTableView.rowHeight = 60
        rootView.fiveDayTableView.dataSource = self
        rootView.fiveDayTableView.delegate = self
        rootView.fiveDayTableView.register(MainFiveDayTableViewCell.self, forCellReuseIdentifier: MainFiveDayTableViewCell.identifier)
    }
    
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputWeathertData.bind { [weak self] weather in
            self?.updateWeatherView(with: weather)
        }
        
        viewModel.outputThreeWeatherData.bind { [weak self] _ in
            self?.rootView.threeHourCollectionView.reloadData()
            self?.rootView.fiveDayTableView.reloadData()
        }
        
        viewModel.outputFiveDayWeatherData.bind { [weak self] _ in
            self?.rootView.fiveDayTableView.reloadData()
        }
        
        viewModel.outputLocationData.bind { [weak self] weather in
            guard let weather = weather else {return}
            self?.updateMapView(with: weather)
        }
    }
    
    private func updateWeatherView(with weather: OpenWeather?) {
        guard let weather = weather else { return }
        
        let cityName = weather.name
        let temp = weather.main.temp
        let detailWeather = weather.weather.first?.main ?? ""
        
        rootView.cityNameLabel.text = cityName
        rootView.temperatureLabel.text = weather.celsius(temp: temp)
        rootView.weatherInformationLabel.text = detailWeather
        rootView.highAndLowLabel.text = weather.maxMinTemp()
        
        rootView.etcCollectionView.reloadData()
    }
    
    private func updateMapView(with weather: WeatherData) {
        rootView.mapView.removeAnnotations(rootView.mapView.annotations)
        let center = CLLocationCoordinate2D(latitude: weather.lat, longitude: weather.lon)
        rootView.mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 200000, longitudinalMeters: 200000)
        let annotation = MKPointAnnotation()
        annotation.coordinate = .init(latitude: weather.lat, longitude: weather.lon)
        rootView.mapView.addAnnotation(annotation)
    }
    
    @objc private func mapClicked() {
        let vc = MapViewController()
        vc.locationData = { [weak self] latitude, longitude in
            self?.viewModel.inputMyLocation.value = [latitude, longitude]
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
        if collectionView == rootView.threeHourCollectionView {
            return viewModel.outputThreeWeatherData.value?.list.count ?? 0
        } else {
            return ETCTypes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == rootView.threeHourCollectionView {
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
        return viewModel.outputFiveDayWeatherData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainFiveDayTableViewCell.identifier, for: indexPath) as! MainFiveDayTableViewCell
        let data = viewModel.outputFiveDayWeatherData.value[indexPath.row]
        cell.configureData(data: data)
        return cell
    }
    
}
