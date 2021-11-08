//
//  ResizeImageDemoVC.swift
//  SYPlan
//
//  Created by Ray on 2020/2/3.
//  Copyright © 2020 Sinyi Realty Inc. All rights reserved.
//

import UIKit

class CropImageDemoVC: AppBaseVC {
    
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    @IBOutlet weak var wTextField: UITextField!
    @IBOutlet weak var hTextField: UITextField!
    
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var originImageView: UIImageView!
    @IBOutlet weak var cropLabel: UILabel!
    @IBOutlet weak var cropImageView: UIImageView!
    @IBOutlet weak var cropButton: UIButton!
    
    private let scale = UIScreen.density
    
    var page: AppContainerVC.Page?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setup() {
        navigationItem.title = page?.title
        view.backgroundColor = .owlBackground
        
        [xTextField, yTextField, wTextField, hTextField].forEach {
            $0?.textColor = .systemGray
            
            if let value = $0?.placeholder {
                $0?.attributedPlaceholder = AttributedStringBuilder(with: value)
                                                    .withForegroundColor(.systemGray)
                                                    .build(length: value.count)
            }
            
            $0?.delegate = self
        }
        
        originLabel.backgroundColor = UIColor(hex: "ffffff", alpha: 0.65)
        cropLabel.backgroundColor = UIColor(hex: "ffffff", alpha: 0.65)
        originImageView.contentMode = .scaleAspectFit
        cropImageView.contentMode = .scaleAspectFit
        
        cropButton.cornerRadius = 9.0
        cropButton.addTarget(self,
                             action: #selector(crop(_:)),
                             for: .touchUpInside)
                
        if let url = Bundle.fileUrl(from: "mobile01-20", withExtension: ".jpg"),
           let data = try? Data(contentsOf: url, options: .mappedIfSafe),
           let image = UIImage(data: data, scale: scale) {
            originImageView.image = image
            originLabel.text = "尺寸：\(image.size.width * scale) x \(image.size.height * scale)"
        }
    }
    
    @objc private func crop(_ button: UIButton) {
        let x = CGFloat(Int(xTextField.text ?? "0") ?? 0)
        let y = CGFloat(Int(yTextField.text ?? "0") ?? 0)
        let w = CGFloat(Int(wTextField.text ?? "0") ?? 0)
        let h = CGFloat(Int(hTextField.text ?? "0") ?? 0)
        
        let image = originImageView.image!
        let cropImage = image.crop(to: CGRect(x: x, y: y, width: w, height: h))
        cropImageView.image = cropImage
        
        let cropW = Int(cropImage.size.width * scale)
        let cropH = Int(cropImage.size.height * scale)
        cropLabel.text = "尺寸：\(cropW) x \(cropH)"
    }
}

extension CropImageDemoVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder { textField.resignFirstResponder() }
        
        return true
    }
}
