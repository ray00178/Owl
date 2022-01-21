//
//  Dictionary+Extension.swift
//  Owl
//
//  Created by Ray on 2021/12/22.
//

import Foundation

extension Dictionary {
    
    /// 將Dictionary轉成Data
    var data: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
    
    /// 將Dictionary轉成String
    var string: String? {
        guard let data = self.data else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
}
