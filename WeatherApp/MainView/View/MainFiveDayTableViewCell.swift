//
//  MainFiveDayTableViewCell.swift
//  WeatherApp
//
//  Created by 전준영 on 7/14/24.
//

import UIKit
import SnapKit
import Kingfisher

final class MainFiveDayTableViewCell: BaseTableViewCell {
    
    let dayLabel = UILabel()
    let weatherImageView = UIImageView()
    let minLabel = UILabel()
    let maxLabel = UILabel()
    
    let stackView = UIStackView()
    
    override func configureHierarchy() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(weatherImageView)
        stackView.addArrangedSubview(minLabel)
        contentView.addSubview(maxLabel)
    }
    
    override func configureLayout() {
        dayLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.centerX.equalTo(contentView).offset(-20)
        }
        
        maxLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.size.equalTo(35)
        }
    }
    
    override func configureView() {
        dayLabel.setUILabel("오늘", textAlignment: .left, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 16), cornerRadius: 0, numberLine: 0)
        minLabel.setUILabel("최저 20도", textAlignment: .left, color: .lightGray, backgroundColor: .clear, font: .systemFont(ofSize: 16), cornerRadius: 0, numberLine: 0)
        maxLabel.setUILabel("최고 20도", textAlignment: .right, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 16), cornerRadius: 0, numberLine: 0)
        stackView.axis = .horizontal
        stackView.spacing = 10
    }
    
    func configureData(data: FiveDayData) {
        
        if let date = FormatterManager.shared.dateFormatter.date(from: data.dt) {
            dayLabel.text = FormatterManager.shared.weekendFormatter.string(from: date)
        } else {
            dayLabel.text = data.dt
        }
        
        minLabel.text = data.minToTemp()
        maxLabel.text = data.maxToTemp()
        
        let imageUrl = URL(string: "\(APIURL.weatherIconURL)\(data.icon)@2x.png")
        weatherImageView.kf.setImage(with: imageUrl)
    }
}
