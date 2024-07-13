//
//  CityTableViewCell.swift
//  WeatherApp
//
//  Created by 전준영 on 7/12/24.
//

import UIKit
import SnapKit

class CityTableViewCell: BaseTableViewCell {
    
    let hashImageView = UIImageView()
    let cityNameLabel = UILabel()
    let countryLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(hashImageView)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(countryLabel)
    }
    
    override func configureLayout() {
        hashImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.leading.equalTo(contentView).inset(20)
            make.size.equalTo(30)
        }
        
        cityNameLabel.snp.makeConstraints { make in
            make.top.equalTo(hashImageView)
            make.leading.equalTo(hashImageView.snp.trailing).offset(10)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.top.equalTo(cityNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(cityNameLabel)
        }
    }
    
    override func configureView() {
        hashImageView.image = UIImage(systemName: "number")
        cityNameLabel.setUILabel("", textAlignment: .left, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 17), cornerRadius: 0, numberLine: 0)
        countryLabel.setUILabel("", textAlignment: .left, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 13), cornerRadius: 0, numberLine: 0)
    }
    
}
