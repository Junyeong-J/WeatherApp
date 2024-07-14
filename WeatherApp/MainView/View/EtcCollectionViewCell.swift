//
//  EtcCollectionViewCell.swift
//  WeatherApp
//
//  Created by 전준영 on 7/14/24.
//

import UIKit
import SnapKit

final class EtcCollectionViewCell: BaseCollectionViewCell {
    
    let titleLabel = UILabel()
    let infoLabel = UILabel()
    let moreInfoLabel = UILabel()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(moreInfoLabel)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(15)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(contentView).inset(15)
        }
        
        moreInfoLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(contentView).inset(15)
        }
    }
    
    override func configureView() {
        titleLabel.setUILabel("타이틀", textAlignment: .left, color: .darkGray, backgroundColor: .clear, font: .systemFont(ofSize: 20), cornerRadius: 0, numberLine: 0)
        infoLabel.setUILabel("30%", textAlignment: .left, color: .black, backgroundColor: .clear, font: .boldSystemFont(ofSize: 28), cornerRadius: 0, numberLine: 0)
        moreInfoLabel.setUILabel("강풍: 000", textAlignment: .left, color: .black, backgroundColor: .clear, font: .systemFont(ofSize: 22), cornerRadius: 0, numberLine: 0)
    }
    
    func configureData(data: ETCType, weather: OpenWeather) {
        titleLabel.text = data.rawValue
        infoLabel.text = data.setInfo(weather: weather)
        if data == .windSpeed {
            moreInfoLabel.isHidden = false
            moreInfoLabel.text = "강풍: \(weather.wind.gust ?? 0)m/s"
        } else {
            moreInfoLabel.isHidden = true
        }
    }
}
