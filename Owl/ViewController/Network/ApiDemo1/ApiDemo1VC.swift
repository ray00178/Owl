//
//  ApiDemo1VC.swift
//  Owl
//
//  Created by Ray on 2021/12/23.
//

import UIKit

class ApiDemo1VC: AppBaseVC {

    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "設定迴圈數量："
        label.textColor = .owlMain
        label.font = .system_regular_18
        label.numberOfLines = 1
        label.useAutoLayout = true
        
        return label
    }()
    
    private lazy var countTextField: UITextField = {
        let tf = UITextField()
        tf.text = "500"
        tf.placeholder = "數量"
        tf.textColor = .owlMain
        tf.font = .system_regular_18
        tf.keyboardType = .numberPad
        tf.borderStyle = .none
        tf.backgroundColor = .owlBackground
        tf.clearButtonMode = .whileEditing
        tf.delegate = self
        tf.useAutoLayout = true
        
        let toolBar = UIToolbar()
        let done = UIBarButtonItem(title: "完成",
                                   style: .plain,
                                   target: self,
                                   action: #selector(done(_:)))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        toolBar.items = [space, done]
        toolBar.sizeToFit()
        tf.inputAccessoryView = toolBar
        tf.inputAccessoryView?.tintColor = .owlMain
        
        return tf
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.useAutoLayout = true
        
        return scrollView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.useAutoLayout = true
        
        return stackView
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .system_regular_16
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var fetchButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("呼叫Api", for: .normal)
        button.setTitleColor(.owlBackground, for: .normal)
        button.titleLabel?.font = .system_medium_18
        button.backgroundColor = .owlMain
        button.useAutoLayout = true
        button.cornerRadius = 30.0
        
        button.addTarget(self,
                         action: #selector(fetch(_:)),
                         for: .touchUpInside)
        
        return button
    }()
    
    private let session: AppURLSession = AppURLSession.share
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup() {
        navigationItem.title = page?.title
        
        view.backgroundColor = .owlBackground
        
        view.addSubview(descLabel)
        view.addSubview(countTextField)
        view.addSubview(scrollView)
        view.addSubview(fetchButton)
        
        scrollView.addSubview(vStackView)
        vStackView.addArrangedSubview(contentLabel)
        
        autoLayout()
    }
    
    private func autoLayout() {
        
        descLabel.topAnchor
                 .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
                 .isActive = true
        descLabel.leadingAnchor
                 .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12.0)
                 .isActive = true
        descLabel.heightAnchor
                 .constraint(equalToConstant: 40.0)
                 .isActive = true
        descLabel.setContentHuggingPriority(.init(250), for: .horizontal)
        
        countTextField.topAnchor
                      .constraint(equalTo: descLabel.topAnchor)
                      .isActive = true
        countTextField.leadingAnchor
                      .constraint(equalTo: descLabel.trailingAnchor, constant: 4.0)
                      .isActive = true
        countTextField.trailingAnchor
                      .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12.0)
                      .isActive = true
        countTextField.heightAnchor
                      .constraint(equalTo: descLabel.heightAnchor)
                      .isActive = true
        countTextField.setContentHuggingPriority(.init(249), for: .horizontal)
        
        scrollView.topAnchor
                  .constraint(equalTo: descLabel.bottomAnchor, constant: 12.0)
                  .isActive = true
        scrollView.leadingAnchor
                  .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
                  .isActive = true
        scrollView.trailingAnchor
                  .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                  .isActive = true
        scrollView.bottomAnchor
                  .constraint(equalTo: fetchButton.topAnchor, constant: -12.0)
                  .isActive = true
        
        vStackView.topAnchor
                  .constraint(equalTo: scrollView.topAnchor)
                  .isActive = true
        vStackView.leadingAnchor
                  .constraint(equalTo: scrollView.leadingAnchor, constant: 12.0)
                  .isActive = true
        vStackView.trailingAnchor
                  .constraint(equalTo: scrollView.trailingAnchor, constant: 12.0)
                  .isActive = true
        vStackView.bottomAnchor
                  .constraint(equalTo: scrollView.bottomAnchor)
                  .isActive = true
        vStackView.widthAnchor
                  .constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0)
                  .isActive = true
        
        let vStackViewHeightConst = vStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.0)
        vStackViewHeightConst.priority = .defaultHigh
        vStackViewHeightConst.isActive = true
        
        fetchButton.leadingAnchor
                   .constraint(equalTo: view.leadingAnchor, constant: 12.0)
                   .isActive = true
        fetchButton.trailingAnchor
                   .constraint(equalTo: view.trailingAnchor, constant: -12.0)
                   .isActive = true
        fetchButton.bottomAnchor
                   .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12.0)
                   .isActive = true
        fetchButton.heightAnchor
                   .constraint(equalToConstant: 60.0)
                   .isActive = true
    }
}

// MARK: - Action

extension ApiDemo1VC {
    
    @objc private func done(_ barButton: UIBarButtonItem) {
        countTextField.resignFirstResponder()
    }
    
    /// 呼叫Api
    @objc private func fetch(_ button: UIButton) {
        guard let value = countTextField.text,
              let count = Int(value),
              count > 0
        else {
            return
        }
        
        fetchButton.isEnabled = false
        
        var dataset: [Data] = []
        var content: [String] = []
                
        var sessionId1: String?
        var sessionId2: String?
        
        let group: DispatchGroup = DispatchGroup()
        
        var req2 = ApiRequest()
        req2.path = .custom(path: "https://www.worldatlas.com/r/w960-q80/upload/56/fb/ee/alaska-mountain-range-csnafzger.jpg")
        
        for _ in 0 ..< count {
            group.enter()
            
            var req1 = ApiRequest()
            req1.path = .custom(path: "https://assets.juksy.com/files/articles/85477/800x_100_w-5c08fb84abf99.jpg")
            
            // 重複建立時，須設置否則會造成因異步導致dictionary remove error問題
            // AppURLSession = self?.tasks.removeValue(forKey: request.key)
            req1.cancelKey = req1.path?.value
            
            sessionId1 = session.fetchData(from: req1, autoCancel: true) { result in
                switch result {
                case .success(let data):
                    dataset.append(data)
                case .failure:
                    content.append("error = \(req1.uuid.uuidString)")
                }
                
                group.leave()
            }
                        
            group.enter()
            
            sessionId2 = session.fetchData(from: req2, autoCancel: true) { result in
                switch result {
                case .success(let data):
                    dataset.append(data)
                case .failure(let error):
                    content.append("error = \(req2.uuid.uuidString)")
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self,
                  dataset.count >= 2
            else {
                return
            }
            
            let format = ByteCountFormatter()
            
            // optional: restricts the units to MB only
            format.allowedUnits = [.useMB]
            format.countStyle = .file
            
            let message = """
            任務 1 \(sessionId1 ?? "")
            檔案大小 = \(format.string(fromByteCount: Int64(dataset[0].count)))
            
            任務 2 \(sessionId2 ?? "")
            檔案大小 = \(format.string(fromByteCount: Int64(dataset[1].count)))
            
            檔案數量 = \(dataset.count)
            取消任務數量 = \(content.count)
            Api任務隊列數量 = \(self.session.tasks.count)
            """
            
            self.contentLabel.text = message
            self.fetchButton.isEnabled = true
        }
    }
}

extension ApiDemo1VC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        switch textField {
        case countTextField:
            return updatedText.count <= 4
        default:
            // true if the specified text range should be replaced;
            // otherwise, false to keep the old text.
            return true
        }
    }
    
}
