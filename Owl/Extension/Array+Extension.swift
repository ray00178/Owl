//
//  Array+Extension.swift
//  Owl
//
//  Created by Ray on 2021/9/15.
//

import UIKit

// MARK: - Common

extension Array {
    
    /// 是否為空陣列
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    /// Array轉成Data
    var data: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
 
    /// 安全取得Arry內元素
    /// - Parameter index: 位置
    /// - Returns: 元素 maybe nil
    func safeGet(_ index: Int) -> Element? {
        if self.isEmpty || index < 0 || index >= self.count {
            return nil
        }
        
        return self[index]
    }
}
