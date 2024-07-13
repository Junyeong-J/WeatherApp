//
//  CityViewController.swift
//  WeatherApp
//
//  Created by 전준영 on 7/12/24.
//

import UIKit

final class CityViewController: BaseViewController {
    
    let cityView = CityView()
    let viewModel = CityViewModel()
    
    override func loadView() {
        view = cityView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI(title: "City")
        bindData()
        configureTableView()
        configureSearchBar()
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureConstraints() {
        
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension CityViewController {
    func makeNavigationUI(title: String) {
        navigationController?.isNavigationBarHidden = false
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBarAppearance.backgroundColor = .white
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .darkGray
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                                                 menu: nil)
        
        navigationItem.title = title
    }
    
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputFilterCityData.bind { _ in
            self.cityView.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        cityView.tableView.dataSource = self
        cityView.tableView.delegate = self
        cityView.tableView.rowHeight = 56
        cityView.tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    private func configureSearchBar() {
        cityView.searchBar.delegate = self
    }
    
    @objc private func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputFilterCityData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as! CityTableViewCell
        cell.configureData(data: viewModel.outputFilterCityData.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.outputFilterCityData.value[indexPath.row]
        viewModel.inputCellSelected.value = data
    }
}

extension CityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputSearchText.value = searchText
    }
}
