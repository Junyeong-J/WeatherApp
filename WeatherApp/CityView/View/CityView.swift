//
//  CityView.swift
//  WeatherApp
//
//  Created by 전준영 on 7/12/24.
//

import UIKit
import SnapKit

class CityView: BaseView {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        searchBar.placeholder = "Search for a city."
    }
    
}

