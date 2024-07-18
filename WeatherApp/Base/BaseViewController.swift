//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by 전준영 on 7/10/24.
//

import UIKit

class BaseViewController<RootView: UIView>: UIViewController {
    
    let rootView: RootView
    
    init() {
        self.rootView = RootView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    func configureHierarchy() {
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureConstraints() {
        
    }
    
    func showAlert(title: String,message: String, ok: String, handler: @escaping (() -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: ok, style: .default) { _ in
            handler()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
}
