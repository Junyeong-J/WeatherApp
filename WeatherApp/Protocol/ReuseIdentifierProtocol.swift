//
//  ReuseIdentifierProtocol.swift
//  WeatherApp
//
//  Created by 전준영 on 7/11/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    
    static var identifier: String { get }
    
}

extension UIViewController: ReuseIdentifierProtocol {
    
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        String(describing: self)
    }
}
