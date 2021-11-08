//
//  Log.swift
//  Owl
//
//  Created by Ray on 2021/11/8.
//

import UIKit
import os.log

struct Log {
    
    private static let subsystem = Bundle.main.bundleIdentifier ?? "nil"
    
    /// Log level is debug
    /// - Parameters:
    ///   - message: Description
    ///   - category: Log category
    ///   - file: file name
    ///   - line: Trigger function line number
    static func debug(message: StaticString,
                      category: Category,
                      file: String = #file,
                      line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        
        os_log(message,
               log: OSLog(subsystem: subsystem,
                          category: category.buildWith(fileName: fileName, line: line)),
               type: .debug)
    }
    
    /// Log level is info
    /// - Parameters:
    ///   - message: Description
    ///   - category: Log category
    ///   - file: file name
    ///   - line: Trigger function line number
    static func info(message: StaticString,
                     category: Category,
                     file: String = #file,
                     line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        
        os_log(message,
               log: OSLog(subsystem: subsystem,
                          category: category.buildWith(fileName: fileName, line: line)),
               type: .debug)
    }
    
    /// Log level is error
    /// - Parameters:
    ///   - message: Description
    ///   - category: Log category
    ///   - file: file name
    ///   - line: Trigger function line number
    static func error(message: StaticString,
                      category: Category,
                      file: String = #file,
                      line: Int = #line) {
        let fileName = (file as NSString).lastPathComponent
        
        os_log(message,
               log: OSLog(subsystem: subsystem,
                          category: category.buildWith(fileName: fileName, line: line)),
               type: .debug)
    }
}

// MARK: - Enum

extension Log {
    
    enum Category: String {
        
        /// UIViewController = 🦁
        case viewcontroller = "🦁"
        
        /// 其他 = 🦊
        case other = "🦊"
        
        /// 組合Log文字
        /// - Parameters:
        ///   - fileName: 觸發檔案名稱
        ///   - line: 觸發行數
        /// - Returns: 組合後Log文字
        func buildWith(fileName: String, line: Int) -> String {
            return self.rawValue.appending(" [\(fileName)(\(line))]")
        }
    }
}
