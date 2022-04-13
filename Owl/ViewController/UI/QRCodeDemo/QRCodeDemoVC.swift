//
//  QRCodeDemoVC.swift
//  Owl
//
//  Created by Ray on 2022/4/13.
//

import UIKit
import AVFoundation

class QRCodeDemoVC: AppBaseVC {
    
    private lazy var captureSession: AVCaptureSession = {
        return  AVCaptureSession()
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.text = "找到條碼來掃描"
        label.textColor = .white
        label.font = .system_bold_20
        label.textAlignment = .center
        label.backgroundColor = .black
        label.cornerRadius = 12.0
        label.useAutoLayout = true
        
        return label
    }()
    
    private lazy var scanBorderView: UIScanBorderView = {
        let scanView = UIScanBorderView()
        scanView.style = frameStyle
        scanView.useAutoLayout = true
        
        return scanView
    }()
    
    /// 支援掃描的類型, value = [.qr]
    private let supportedBarCodes: [AVMetadataObject.ObjectType] = [.qr]
    
    /// 掃描匡尺寸大小, default = .normal
    var frameStyle: UIScanBorderView.Style = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        addDescAndScanBorderView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if captureSession.isRunning == false {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    private func setup() {
        navigationItem.title = page?.title
        
        // Check
        
        // 檢查是否有攝影裝置
        guard let device = AVCaptureDevice.default(for: .video) else {
            showFailureAlert(with: "您的設備未有設攝影鏡頭")
            return
        }
        
        guard let input = try? AVCaptureDeviceInput(device: device) else {
            showFailureAlert(with: "發生錯誤...")
            return
        }
        
        // 檢查是否可加入Input
        guard captureSession.canAddInput(input) else {
            showFailureAlert(with: "您的設備不支持掃描項目中的條碼類型")
            return
        }
        
        let output = AVCaptureMetadataOutput()
        
        // 檢查是否可加入Output
        guard captureSession.canAddOutput(output) else {
            showFailureAlert(with: "您的設備不支持掃描項目中的條碼類型")
            return
        }
        
        captureSession.addInput(input)
        captureSession.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = supportedBarCodes
        
        // 律定掃描區域範圍，注意x, y, w, h 與設定區域`相反`
        // reference：https://qiita.com/tomosooon/items/9cb7bf161a9f76f3199b
        // reference：https://swiswiswift.com/barcode/
        let width = view.frame.width
        let height = view.frame.height
        
        // 掃描邊框的尺寸
        let size = frameStyle.size
        
        // 計算掃描邊框`寬度`對於整個螢幕`寬度`的比例
        let ratioW = size.width / width
        
        // 計算掃描邊框`高度`對於整個螢幕`高度`的比例
        let ratioH = size.height / height
        
        // 預設掃描區域範圍為：0.0, 0.0, 1.0, 1.0，故需要做比例上的計算
        let x = 1 - ratioH - ((height - size.height) / 2 / height)
        let y = 1 - ratioW - ((width - size.width) / 2 / width)
        let w = ratioH
        let h = ratioW
        output.rectOfInterest = CGRect(x: x, y: y, width: w, height: h)
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        // 開始掃描
        captureSession.commitConfiguration()
        captureSession.startRunning()
    }
    
    private func addDescAndScanBorderView() {
        view.addSubview(scanBorderView)
        view.addSubview(descLabel)
        
        // AutoLayout
        scanBorderView.topAnchor
                      .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
                      .isActive = true
        scanBorderView.leadingAnchor
                      .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
                      .isActive = true
        scanBorderView.trailingAnchor
                      .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                      .isActive = true
        scanBorderView.bottomAnchor
                      .constraint(equalTo: view.bottomAnchor)
                      .isActive = true
        
        descLabel.topAnchor
                 .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40.0)
                 .isActive = true
        descLabel.centerXAnchor
                 .constraint(equalTo: view.centerXAnchor)
                 .isActive = true
        descLabel.widthAnchor
                 .constraint(equalToConstant: 200.0)
                 .isActive = true
        descLabel.heightAnchor
                 .constraint(equalToConstant: 60.0)
                 .isActive = true
    }
}

extension QRCodeDemoVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        
        captureSession.stopRunning()
        
        // 是否有資訊物件
        guard let metadataObject = metadataObjects.first else { return }
        
        // 是否可轉換為機器可讀object
        guard let object = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
        
        // 檢查object型別是否為`QRCode`，並且有value
        guard object.type == .qr, let value = object.stringValue else { return }
        
        // 顯示掃描結果
        outputValue(with: value)
    }
}

// MARK: - Function

extension QRCodeDemoVC {
    
    /// 顯示錯誤訊息Alert
    /// - Parameter message: 錯誤訊息
    private func showFailureAlert(with message: String?) {
        let ac = UIAlertController(title: "錯誤", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "關閉", style: .default, handler: nil))
        ac.view.tintColor = .owlMain
        
        present(to: ac, style: .fullScreen, animated: true, completion: nil)
    }
    
    /// 顯示掃描結果Alert
    /// - Parameter text: 掃描結果文字
    private func outputValue(with text: String) {
        let ac = UIAlertController(title: "掃描結果：\(text)", message: nil, preferredStyle: .alert)
        
        let close = UIAlertAction(title: "關閉", style: .default) { [weak self] _ in
            self?.captureSession.startRunning()
        }
        
        ac.addAction(close)
        ac.view.tintColor = .owlMain
        
        present(to: ac, style: .fullScreen, animated: true, completion: nil)
    }
}
