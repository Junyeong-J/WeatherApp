//
//  MapView.swift
//  WeatherApp
//
//  Created by 전준영 on 7/16/24.
//

import UIKit
import SnapKit
import MapKit

final class MapView: BaseView {
    
    let mapView = MKMapView()
    
    override func configureHierarchy() {
        addSubview(mapView)
    }
    
    override func configureLayout() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
    
}
