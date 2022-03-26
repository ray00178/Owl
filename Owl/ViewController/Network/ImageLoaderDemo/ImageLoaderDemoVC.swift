//
//  ImageLoaderDemoVC.swift
//  Owl
//
//  Created by Ray on 2022/3/26.
//

import UIKit

class ImageLoaderDemoVC: AppBaseVC {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 80.0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.useAutoLayout = true
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationItem.title = "Image Loader Demo"
        
        view.addSubview(tableView)
        view.backgroundColor = .white
        
        autoLayout()
    }
    
    private func autoLayout() {
        tableView.topAnchor
                 .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
                 .isActive = true
        tableView.leadingAnchor
                 .constraint(equalTo: view.leadingAnchor)
                 .isActive = true
        tableView.trailingAnchor
                 .constraint(equalTo: view.trailingAnchor)
                 .isActive = true
        tableView.bottomAnchor
                 .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                 .isActive = true
    }
}

extension ImageLoaderDemoVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
