//
//  UITableView+Extension.swift
//  Owl
//
//  Created by Ray on 2021/9/8.
//

import UIKit

extension UITableView {
    
    /// 註冊各類型UITableViewCell
    /// - Parameters:
    ///   - t: Cell Type
    ///   - fromNib: 是否為UINib，default：true
    /// ```
    /// How to use：
    /// let tableView = UITableView(frame: .zero, style: .plain)
    /// tableView.registerCell(UITableViewCell.self)
    /// or
    /// tableView.registerCell(UITableViewCell.self, fromNib: false)
    /// ```
    func registerCell<T: UITableViewCell>(_ t: T.Type, fromNib: Bool = true) {
        let identifier = String(describing: t)
        if fromNib {
            self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        } else {
            self.register(t, forCellReuseIdentifier: identifier)
        }
    }
    
    /// 取得各類型UITableViewCell
    /// - Parameters:
    ///   - t: Cell Type
    /// - Returns: UITableViewCell
    /// ```
    /// How to use：
    /// tableView.dequeueCell(UITableViewCell.self, indexPath: indexPath)
    /// ```
    func dequeueCell<T: UITableViewCell>(_ t: T.Type) -> T {
        let identifier = String(describing: t)
        
        guard let type = self.dequeueReusableCell(withIdentifier: identifier) as? T else {
            fatalError("TableView dequeueReusableCell 👉🏻 \(identifier) not found.")
        }
        
        return type
    }
    
    /// 取得各類型UITableViewCell
    /// - Parameters:
    ///   - t: Cell Type
    ///   - indexPath: IndexPath
    /// - Returns: UITableViewCell
    /// ```
    /// How to use：
    /// tableView.dequeueCell(UITableViewCell.self, indexPath: indexPath)
    /// ```
    func dequeueCell<T: UITableViewCell>(_ t: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: t)
        
        guard let type = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T
        else {
            fatalError("TableView dequeueReusableCell 👉🏻 \(identifier) not found.")
        }
        
        return type
    }
    
}
