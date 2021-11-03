//
//  CompositionalLayoutVC.swift
//  Owl
//
//  Created by Ray on 2021/11/3.
//

import UIKit

/// Compositional Layout Demo
/// Reference = https://www.appcoda.com.tw/compositional-layout/
@available(iOS 13.0, *)
class CompositionalLayoutVC: AppBaseVC {

    /// 單個Section例子
    private lazy var compositionalLayout1: UICollectionViewCompositionalLayout = {
        // Cell 大小
        // .absolute = 固定大小
        // .fractionalWidth(Height) = 依照當前群組的大小，按比例計算
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Item padding，會縮小 Item 的大小
        //item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 10.0)
        
        // Item padding，不會縮小 Item 的大小
        //let itemEdgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(10.0), top: .fixed(0.0), trailing: .fixed(10.0), bottom: .fixed(0.0))
        //item.edgeSpacing = itemEdgeSpacing
        
        // 群組大小
        // .absolute = 固定大小
        // .fractionalWidth(Height) = 依照當前collectionView的大小，按比例計算
        // .estimated = 自動計算大小
        // 優先度 = groupSize > itemSize
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .absolute(200.0))
        
        // 群組排列的方向(Horizontal)
        // layoutSize = 群組大小
        // item = 固定Item
        // count = 群組內包含幾個Item，有設定時其Item widthDimension無作用
        var group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 2)
        
        // 群組排列的方向(Vertical)
        //group = .vertical(layoutSize: groupSize, subitem: item, count: 2)
        
        // Group padding，會縮小 Group 的大小
        //group.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 4.0, bottom: 4.0, trailing: 4.0)
        
        // Group padding，不會縮小 Group 的大小
        //let groupEdgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(10.0), top: .fixed(0.0), trailing: .fixed(10.0), bottom: .fixed(0.0))
        //group.edgeSpacing = groupEdgeSpacing
        
        // Group inner item padding
        group.interItemSpacing = .fixed(12.0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        // 1. 顧名思義，就是不會有垂直向的滾動（預設值）
        //section.orthogonalScrollingBehavior = .none
        
        // 2. 連續的滾動
        //section.orthogonalScrollingBehavior = .continuous
        
        // 3. 連續的滾動，但會最後停在 group 的前緣
        //section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        // 4. 每次會滾動跟 CollectionView 一樣寬（或一樣高）的距離
        //section.orthogonalScrollingBehavior = .paging
        
        // 5. 每次會滾動一個 group
        section.orthogonalScrollingBehavior = .groupPaging
        
        // 6. 每次會滾動一個 group，並且停在 group 置中的地方
        //section.orthogonalScrollingBehavior = .groupPagingCentered
        
        // Section padding
        section.contentInsets = NSDirectionalEdgeInsets(top: 12.0, leading: 12.0, bottom: 0.0, trailing: 12.0)
        
        // Section inner group padding
        section.interGroupSpacing = 12.0
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        // 處理滾動的方向，default = vertical
        //let configuration = UICollectionViewCompositionalLayoutConfiguration()
        //configuration.scrollDirection = .vertical
        
        //let layout = UICollectionViewCompositionalLayout(section: section, configuration: configuration)
        
        return layout
    }()
    
    /// 多個Section例子
    private lazy var compositionalLayout2: UICollectionViewCompositionalLayout = {
        
        func section1() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                   heightDimension: .absolute(200.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: 2)
            group.interItemSpacing = .fixed(12.0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.contentInsets = NSDirectionalEdgeInsets(top: 12.0,
                                                            leading: 12.0,
                                                            bottom: 12.0,
                                                            trailing: 12.0)
            section.interGroupSpacing = 12.0
            
            return section
        }
        
        func section2() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(160.0))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: 2)
            group.interItemSpacing = .fixed(12.0)
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            section.contentInsets = NSDirectionalEdgeInsets(top: 0.0,
                                                            leading: 12.0,
                                                            bottom: 12.0,
                                                            trailing: 12.0)
            section.interGroupSpacing = 12.0
            
            return section
        }
        
        let layout = UICollectionViewCompositionalLayout { section, environment in
            switch section {
            case 0:
                return section1()
            case 1:
                return section2()
            default:
                return nil
            }
        }
        
        return layout
    }()
    
    /// 多個Group例子
    private lazy var compositionalLayout3: UICollectionViewCompositionalLayout = {
        // Left
        let itemSize1 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.5))
        let item1 = NSCollectionLayoutItem(layoutSize: itemSize1)
        
        let leftGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                   heightDimension: .fractionalHeight(1.0))
        let leftGroup = NSCollectionLayoutGroup.vertical(layoutSize: leftGroupSize,
                                                         subitem: item1,
                                                         count: 2)
        leftGroup.interItemSpacing = .fixed(1.0)
        
        // Right
        let itemSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(1.0))
        let item2 = NSCollectionLayoutItem(layoutSize: itemSize2)
        
        let rightGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                    heightDimension: .fractionalHeight(1.0))
        let rightGroup = NSCollectionLayoutGroup.vertical(layoutSize: rightGroupSize,
                                                          subitems: [item2])
        rightGroup.contentInsets = .init(top: 0.0, leading: 1.0, bottom: 0.0, trailing: 0.0)
        
        // Container Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(200.0))
        var group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [leftGroup, rightGroup])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.interGroupSpacing = 1.0
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: compositionalLayout2)
        collectionView.registerCell(PinterestCell.self, isNib: true)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.useAutoLayout = true
        return collectionView
    }()
    
    private var dataset: [Pinterest] = []
    
    var page: AppContainerVC.Page?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        createFakeDataset()
    }
    
    private func setup() {
        navigationItem.title = page?.title
        
        let barChange = UIBarButtonItem(title: "Change",
                                        style: .plain,
                                        target: self,
                                        action: nil)
        navigationItem.rightBarButtonItem = barChange
        
        if #available(iOS 14.0, *) {
            barChange.menu = UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [
                UIAction(title: "CompositionalLayout1", handler: { [weak self] (action) in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.collectionView.setCollectionViewLayout(strongSelf.compositionalLayout1,
                                                                      animated: false)
                }),
                UIAction(title: "CompositionalLayout2", handler: { [weak self] (action) in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.collectionView.setCollectionViewLayout(strongSelf.compositionalLayout2,
                                                                      animated: false)
                }),
                UIAction(title: "CompositionalLayout3", handler: { [weak self] (action) in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.collectionView.setCollectionViewLayout(strongSelf.compositionalLayout3,
                                                                      animated: false)
                })
            ])
        } else {
            // do nothing...
        }
        
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
                      .constraint(equalTo: view.bottomAnchor, constant: 0.0)
                      .isActive = true
    }
    
    private func createFakeDataset() {
        for i in 0 ... 20 {
            let path = Bundle.filePath(from: "mobile01-\(i)", withExtension: "jpg")
            dataset.append(Pinterest(path: path, title: "Mobile01-\(i + 1)"))
        }
        
        collectionView.reloadData()
    }
    
    @objc private func changeLayout(_ barButton: UIBarButtonItem) {
        
    }
}

@available(iOS 13.0, *)
extension CompositionalLayoutVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewCompositionalLayout {
            switch layout {
            case compositionalLayout1:
                return 1
            case compositionalLayout2:
                return 2
            case compositionalLayout3:
                return 1
            default:
                return 0
            }
        } else {
            return 0
        }
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
