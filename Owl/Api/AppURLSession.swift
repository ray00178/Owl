//
//  AppURLSession.swift
//  Owl
//
//  Created by Ray on 2021/12/22.
//

import Foundation

/// Origin URLSession
class AppURLSession: NSObject {
    
    static let share: AppURLSession = AppURLSession()
    
    private var session: URLSession?
    
    /// 任務隊列
    private(set) var tasks: Dictionary<String, URLSessionDataTask?> = [:]
    
    private override init() {
        super.init()
        
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let timeout: TimeInterval = 60 * 2
        
        // 相同Server最大連接數量
        //config.httpMaximumConnectionsPerHost = 1
        
        config.networkServiceType = .default
        
        // 連接超時時間
        config.timeoutIntervalForRequest = timeout
        
        // 資源超時時間，一般用於上傳或下載任務
        // 在上傳或下載任務開始後計時，如果到達時間任務未結束，則刪除資源文件。單位為秒，默認時間是七天。
        //config.timeoutIntervalForResource = 60 * 60 * 24
        
        session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }
    
    /// 取得資料
    /// - Parameters:
    ///   - request: 請求 Model
    ///   - autoCancel: 是否自動取消同樣的請求 Model
    ///   - completion: 成功或失敗的回調
    ///   - didFinish: 結束的回調
    /// - Returns: 該次請求的識別碼
    @discardableResult
    public func fetchData(from request: ApiRequest,
                          autoCancel: Bool = true,
                          completion: ((Result<Data, ApiError>) -> Swift.Void)?,
                          didFinish: (() -> Swift.Void)? = nil) -> String? {
        
        if autoCancel {
            cancel(to: request)
        }
        
        guard let path = request.path else {
            completion?(.failure(.pathNil))
            return nil
        }
        
        guard let url = URL(string: path.value) else {
            completion?(.failure(.urlNil))
            return nil
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = request.method.rawValue
        req.httpBody = request.parameters?.data
        request.headers.forEach { req.addValue($0.value, forHTTPHeaderField: $0.field) }
        
        let task = session?.dataTask(with: req, completionHandler: { [weak self] (data, response, error) in
            
            guard let _ = (response as? HTTPURLResponse)?.statusCode else {
                completion?(.failure(.noResponseCode))
                return
            }
            
            if let err = error {
                let nserror = err as NSError
                let code = nserror.code
                let description = nserror.localizedDescription
                
                switch code {
                case NSURLErrorCancelled:
                    completion?(.failure(.cancel))
                case NSURLErrorTimedOut:
                    completion?(.failure(.timeout))
                case NSURLErrorCannotFindHost:
                    completion?(.failure(.cannotFindHost))
                case NSURLErrorCannotConnectToHost:
                    completion?(.failure(.cannotConnectToHost))
                case NSURLErrorNotConnectedToInternet:
                    completion?(.failure(.notConnectedToInternet))
                default:
                    completion?(.failure(.unknowError(message: description)))
                }
                
                return
            }
            
            guard let data = data else {
                completion?(.failure(.responseDataNil))
                return
            }
            
            completion?(.success(data))
            
            self?.tasks.removeValue(forKey: request.key)
        })
        
        tasks[request.key] = task
        
        task?.resume()
        
        return request.uuid.uuidString
    }
    
    public func cancel(to cancel: Cancelable) {
        
        guard let task = tasks.removeValue(forKey: cancel.key)
        else {
            return
        }
        
        // Cancel時，會走.noResponseCode
        task?.cancel()
        
        if let state = task?.state, let path = task?.originalRequest?.url?.absoluteString {
            print("Cancel task state = \(state.rawValue) in \(path)")
        }
    }
}

extension AppURLSession: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL) {
        
    }
    
    // Send Data
    func urlSession(_ session: URLSession,
                    task: URLSessionTask,
                    didSendBodyData bytesSent: Int64,
                    totalBytesSent: Int64,
                    totalBytesExpectedToSend: Int64) {
        
    }
    
    // Download Data
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didWriteData bytesWritten: Int64,
                    totalBytesWritten: Int64,
                    totalBytesExpectedToWrite: Int64) {
        
    }
}
