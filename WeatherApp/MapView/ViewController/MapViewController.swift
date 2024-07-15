//
//  MapViewController.swift
//  WeatherApp
//
//  Created by 전준영 on 7/16/24.
//

import UIKit

final class MapViewController: BaseViewController {
    
    let mapView = MapView()
    
    override func loadView() {
        view = mapView
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureConstraints() {
        
    }
    
    override func configureView() {
        super.configureView()
    }
    
}
