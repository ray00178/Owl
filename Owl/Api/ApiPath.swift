//
//  ApiPath.swift
//  Owl
//
//  Created by Ray on 2021/12/22.
//

import Foundation

enum ApiError: Error {
    
    case pathNil
    
    case urlNil
    
    case noResponseCode
    
    case cancel
    
    case timeout
    
    case cannotFindHost
    
    case cannotConnectToHost
    
    case notConnectedToInternet
    
    case unknowError(message: String)
    
    case responseDataNil
    
    case parseDataFailed(message: String)
    
    case convertDictionaryFailed
    
    case convertImageFailed
}

enum ApiPath: Hashable {
    
    /// 自定義
    case custom(path: String)
    
    /// Return fully path
    var value: String {
        switch self {
        case .custom(let path):
            return path
        }
    }
}
