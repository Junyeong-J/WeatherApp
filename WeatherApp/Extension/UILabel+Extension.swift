//
//  UILabel+Extension.swift
//  WeatherApp
//
//  Created by 전준영 on 7/11/24.
//

import UIKit

extension UILabel {
    
    func setUILabel(_ title: String, textAlignment: NSTextAlignment, color: UIColor, backgroundColor: UIColor, font: UIFont, cornerRadius: Double, numberLine: Int) {
        
        self.text = title
        self.textAlignment = textAlignment
        self.textColor = color
        self.font = font
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.numberOfLines = numberLine
        
    }
    
}
