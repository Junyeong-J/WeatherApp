//
//  MapViewController.swift
//  WeatherApp
//
//  Created by 전준영 on 7/16/24.
//

import UIKit
import MapKit

final class MapViewController: BaseViewController<MapView> {
    
    var locationData: ((Double, Double) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocation()
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureConstraints() {
        
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension MapViewController {
    func configureLocation() {
        rootView.locationManager.delegate = self
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        rootView.mapView.setRegion(region, animated: true)
    }
    
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async { [weak self] in
            if CLLocationManager.locationServicesEnabled() {
                self?.checkCurrentLocationAuthorization()
            } else {
                let alert = UIAlertController(title: nil, message: "위치 서비스가 꺼져 있어서, 위치 권한 요청을 할 수 없어요.", preferredStyle: .alert)
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func checkCurrentLocationAuthorization() {
        
        var status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = rootView.locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            rootView.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            rootView.locationManager.requestWhenInUseAuthorization()
        case .denied:
            setRegionAndAnnotation(center: CLLocationCoordinate2D(latitude: 37.517742, longitude: 126.886463))
            showAlertToOpenSettings()
        case .authorizedWhenInUse:
            rootView.locationManager.startUpdatingLocation()
        default:
            print(status)
        }
    }
    
    func showAlertToOpenSettings() {
        let alert = UIAlertController(title: "위치 권한", message: "위치 서비스가 꺼져 있어서, 위치 권한을 설정화면에서 켜 주세요.", preferredStyle: .alert)
        
        let settingURL = UIAlertAction(title: "권한 설정하기", style: .default) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(settingURL)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func setNaviBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonClicked() {
        if let location = rootView.locationManager.location?.coordinate {
            locationData?(location.latitude, location.longitude)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print("lat: \(coordinate.latitude), lon: \(coordinate.longitude)")
            locationData?(coordinate.latitude, coordinate.longitude)
            setRegionAndAnnotation(center: coordinate)
        }
        rootView.locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkDeviceLocationAuthorization()
    }
    
}
