//
//  MainThreeCollectionViewCell.swift
//  WeatherApp
//
//  Created by 전준영 on 7/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class MainThreeCollectionViewCell: BaseCollectionViewCell {
    
    let timeLabel = UILabel()
    let weatherImageView = UIImageView()
    let tempLabel = UILabel()
    let stackView = UIStackView()
    
    override func configureHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(tempLabel)
    }
    
    override func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView).inset(10)
            make.horizontalEdges.equalTo(contentView).inset(5)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.size.equalTo(50)
        }
    }
    
    override func configureView() {
        stackView.axis = .vertical
        stackView.spacing = 10 
        timeLabel.setUILabel("안녕", textAlignment: .center, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 17), cornerRadius: 0, numberLine: 1)
        weatherImageView.backgroundColor = .red
        tempLabel.setUILabel("10도", textAlignment: .center, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 17), cornerRadius: 0, numberLine: 1)
    }
    
    func configureData(data: WeatherList) {
        let imageUrl = URL(string: "\(APIURL.weatherIconURL)\(data.weather.first?.icon ?? "")@2x.png")
        weatherImageView.kf.setImage(with: imageUrl)
        timeLabel.text = data.dt_txt
        tempLabel.text = "\(data.main.temp)"
    }
}
