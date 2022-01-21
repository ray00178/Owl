//
//  PinterestVC.swift
//  Owl
//
//  Created by Ray on 2021/9/15.
//

import UIKit

/// Custom CollectionView Layout Page
class PinterestVC: AppBaseVC {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: pinterestLayout)
        collectionView.registerCell(PinterestCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.useAutoLayout = true
        
        return collectionView
    }()
        
    private lazy var pinterestLayout: PinterestLayout = {
        let layout = PinterestLayout()
        layout.delegate = self
        return layout
    }()
    
    private var dataset: [Pinterest] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        createFakeDataset()
    }
    
    private func setup() {
        navigationItem.title = page?.title
        view.addSubview(collectionView)
        
        autoLayout()
    }
    
    private func autoLayout() {
        collectionView.topAnchor
                      .constraint(equalTo: view.topAnchor)
                      .isActive = true
        collectionView.leadingAnchor
                      .constraint(equalTo: view.leadingAnchor)
                      .isActive = true
        collectionView.trailingAnchor
                      .constraint(equalTo: view.trailingAnchor)
                      .isActive = true
        collectionView.bottomAnchor
                      .constraint(equalTo: view.bottomAnchor)
                      .isActive = true
    }
    
    private func createFakeDataset() {
        for i in 0 ... 20 {
            let path = Bundle.filePath(from: "mobile01-\(i)", withExtension: "jpg")
            dataset.append(Pinterest(path: path, title: "Mobile01-\(i + 1)"))
        }
        
        collectionView.reloadData()
    }
}

extension PinterestVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataset.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(PinterestCell.self, indexPath: indexPath)
        cell.data = dataset[indexPath.row]
        return cell
    }
}

// MARK: - PinterestLayoutDelegate

extension PinterestVC: PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return (indexPath.row % 4 == 0 || indexPath.row % 4 == 3) ? 180.0 : 200.0
    }
}
