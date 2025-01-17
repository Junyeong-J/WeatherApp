//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by 전준영 on 7/11/24.
//

import UIKit
import SnapKit
import MapKit

final class MainWeatherView: BaseView {

    let mainScrollView = UIScrollView()
    let contentView = UIView()
    
    let cityNameLabel = UILabel()
    let temperatureLabel = UILabel()
    let weatherInformationLabel = UILabel()
    let highAndLowLabel = UILabel()
    
    let threeHourView = UIView()
    let threeHourTitleView = UIView()
    let threeHourTitleLabel = UILabel()
    lazy var threeHourCollectionView = UICollectionView(frame: .zero, collectionViewLayout: threeHourCollectionViewLayout())
    private func threeHourCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 8
        let cellSpacing: CGFloat = 4
        let width = 50
        layout.itemSize = CGSize(width: width, height: width * 3)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    let fiveDayView = UIView()
    let fiveDayTitleView = UIView()
    let fiveDayTitleLabel = UILabel()
    let fiveDayTableView = UITableView()
    
    let locationView = UIView()
    let locationTitleView = UIView()
    let locationTitleLabel = UILabel()
    let mapView = MKMapView()
    
    let etcView = UIView()
    lazy var etcCollectionView = UICollectionView(frame: .zero, collectionViewLayout: etcCollectionViewLayout())
    
    func etcCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing)
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherInformationLabel)
        contentView.addSubview(highAndLowLabel)
        
        contentView.addSubview(threeHourView)
        threeHourView.addSubview(threeHourTitleView)
        threeHourTitleView.addSubview(threeHourTitleLabel)
        threeHourView.addSubview(threeHourCollectionView)
        
        contentView.addSubview(fiveDayView)
        fiveDayView.addSubview(fiveDayTitleView)
        fiveDayTitleView.addSubview(fiveDayTitleLabel)
        fiveDayView.addSubview(fiveDayTableView)
        
        contentView.addSubview(locationView)
        locationView.addSubview(locationTitleView)
        locationTitleView.addSubview(locationTitleLabel)
        locationView.addSubview(mapView)
        
        contentView.addSubview(etcView)
        etcView.addSubview(etcCollectionView)
    }
    
    override func configureLayout() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(mainScrollView.snp.width)
            make.verticalEdges.equalTo(mainScrollView)
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
            make.height.equalTo(200)
        }
        
        threeHourTitleView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(threeHourView)
            make.height.equalTo(50)
        }
        
        threeHourTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(threeHourTitleView)
            make.leading.equalTo(10)
        }
        
        threeHourCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(threeHourView)
            make.height.equalTo(150)
        }
        
        
        fiveDayView.snp.makeConstraints { make in
            make.top.equalTo(threeHourView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(350)
        }
        
        fiveDayTitleView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(fiveDayView)
            make.height.equalTo(50)
        }
        
        fiveDayTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(fiveDayTitleView)
            make.leading.equalTo(10)
        }
        
        fiveDayTableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(fiveDayView)
            make.height.equalTo(300)
        }
        
        locationView.snp.makeConstraints { make in
            make.top.equalTo(fiveDayView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(300)
        }
        
        locationTitleView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(locationView)
            make.height.equalTo(50)
        }
        
        locationTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationTitleView)
            make.leading.equalTo(10)
        }
        
        mapView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(locationView)
            make.height.equalTo(250)
        }
        
        etcView.snp.makeConstraints { make in
            make.top.equalTo(locationView.snp.bottom).offset(10)
            make.bottom.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(360)
        }
        
        etcCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(etcView)
        }
    }
    
    override func configureView() {
        cityNameLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 40), cornerRadius: 0, numberLine: 0)
        temperatureLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 70), cornerRadius: 0, numberLine: 0)
        weatherInformationLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 30), cornerRadius: 0, numberLine: 0)
        highAndLowLabel.setUILabel("", textAlignment: .center, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 20), cornerRadius: 0, numberLine: 0)
        
        threeHourTitleLabel.setUILabel("3시간 간격의 일기예보", textAlignment: .left, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 19), cornerRadius: 0, numberLine: 0)
        fiveDayTitleLabel.setUILabel("5일 간의 일기예보", textAlignment: .left, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 19), cornerRadius: 0, numberLine: 0)
        locationTitleLabel.setUILabel("위치", textAlignment: .left, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 19), cornerRadius: 0, numberLine: 0)
        
    }
}
