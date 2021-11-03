//
//  UICollectionView+Extension.swift
//  Owl
//
//  Created by Ray on 2021/9/28.
//

import UIKit

extension UICollectionView {
    
    /// 註冊各類型UICollectionViewCell
    /// - Parameters:
    ///   - t: Cell Type
    ///   - isNib: 是否為UINib，default：true
    /// ```
    /// How to use：
    /// let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    /// collectionView.registerCell(UICollectionViewCell.self)
    /// or
    /// collectionView.registerCell(UICollectionViewCell.self, fromNib: false)
    /// ```
    func registerCell<T: UICollectionViewCell>(_ t: T.Type, isNib: Bool = true) {
        let identifier = String(describing: t)
        if isNib {
            self.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        } else {
            self.register(t, forCellWithReuseIdentifier: identifier)
        }
    }
    
    /// 取得各類型UICollectionViewCell
    /// - Parameters:
    ///   - t: Cell Type
    ///   - indexPath: IndexPath
    /// - Returns: UICollectionViewCell
    /// ```
    /// How to use：
    /// collectionView.dequeueCell(UICollectionViewCell.self, indexPath: indexPath)
    /// ```
    func dequeueCell<T: UICollectionViewCell>(_ t: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: t)
        return self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
}
