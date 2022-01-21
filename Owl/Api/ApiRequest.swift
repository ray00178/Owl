//
//  ApiRequest.swift
//  Owl
//
//  Created by Ray on 2021/12/22.
//

import Foundation

protocol Cancelable {
    
    var key: String { get }
    
}

/// Api Request
struct ApiRequest: Cancelable {
    
    private(set) var uuid: UUID
    
    /// Http method Default = .get
    var method: ApiRequest.Method = .get
    
    /// Http header
    var headers: [ApiRequest.Header] = []
    
    /// Http host path
    var path: ApiPath?
    
    /// Http post body
    var parameters: Dictionary<String, Any>?
    
    /// 請求取消時的識別碼
    var key: String {
        if let cancel = cancelKey,
           cancel.isEmpty == false {
            return cancel
        }
        
        return uuid.uuidString
    }
    
    var cancelKey: String?
    
    init() {
        uuid = UUID()
    }
}

// MARK: - Enum

extension ApiRequest {
    
    /// Http method
    enum Method: String {
        
        case get = "GET"
        
        case post = "POST"
    }
    
    enum Header {
        
        case xml
        
        case json
        
        case authorization(value: String)
        
        var field: String {
            switch self {
            case .xml, .json:
                return "Content-Type"
            case .authorization:
                return "Authorization"
            }
        }
            
        var value: String {
            switch self {
            case .xml:
                return "text/xml; charset=utf-8"
            case .json:
                return "application/json"
            case .authorization(let value):
                return "Bearer \(value)"
            }
        }
    }
}
