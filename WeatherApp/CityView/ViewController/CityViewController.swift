//
//  CityViewController.swift
//  WeatherApp
//
//  Created by 전준영 on 7/12/24.
//

import UIKit

final class CityViewController: BaseViewController<CityView> {
    
    let viewModel = CityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavigationUI(title: "City",leftButtonAction: #selector(backButtonClicked) , rightButtonImage: UIImage(systemName: "ellipsis.circle"))
        bindData()
        configureTableView()
        configureSearchBar()
    }
    
    deinit {
        print("CityViewController Deinit")
    }
    
    override func configureView() {
        super.configureView()
    }
    
}

extension CityViewController {
    
    private func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputFilterCityData.bind { [weak self] _ in
            self?.rootView.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.tableView.rowHeight = 56
        rootView.tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    private func configureSearchBar() {
        rootView.searchBar.delegate = self
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
        navigationController?.popViewController(animated: true)
    }
}

extension CityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputSearchText.value = searchText
    }
}
