//
//  Bundle+Extension.swift
//  Owl
//
//  Created by Ray on 2021/9/28.
//

import Foundation

extension Bundle {
    
    /// 取得檔案Path
    /// - Parameters:
    ///   - fileName: 檔案名稱
    ///   - withExtension: 檔案副檔名
    static func filePath(from fileName: String?, withExtension: String?) -> String? {
        return Bundle.main.path(forResource: fileName, ofType: withExtension)
    }
    
    /// 取得檔案Url
    /// - Parameters:
    ///   - fileName: 檔案名稱
    ///   - withExtension: 檔案副檔名
    static func fileUrl(from fileName: String?, withExtension: String?) -> URL? {
        return Bundle.main.url(forResource: fileName, withExtension: withExtension)
    }
}
