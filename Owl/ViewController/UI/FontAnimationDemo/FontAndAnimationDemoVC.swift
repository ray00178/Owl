//
//  FontAndAnimationDemoVC.swift
//  Owl
//
//  Created by Ray on 2021/9/28.
//

import UIKit

/// 字型風格與文字動畫 Page
class FontAndAnimationDemoVC: AppBaseVC {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.useAutoLayout = true
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.useAutoLayout = true
        return containerView
    }()
        
    private lazy var vStackView: UIStackView = {
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.spacing = 12.0
        vStackView.useAutoLayout = true
        return vStackView
    }()
    
    private lazy var animationLabel: UIAnimationLabel = {
        let label = UIAnimationLabel()
        label.text = " "
        label.textColor = .owlGrayOne
        label.textAlignment = .center
        label.font = .system_medium_16
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        navigationItem.title = page?.title
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(vStackView)
        
        autoLayout()
        
        createAnimationLabel()
        createFontLabel()
    }
    
    private func autoLayout() {
        scrollView.topAnchor
                  .constraint(equalTo: view.topAnchor)
                  .isActive = true
        scrollView.leadingAnchor
                  .constraint(equalTo: view.leadingAnchor)
                  .isActive = true
        scrollView.trailingAnchor
                  .constraint(equalTo: view.trailingAnchor)
                  .isActive = true
        scrollView.bottomAnchor
                  .constraint(equalTo: view.bottomAnchor)
                  .isActive = true
        
        containerView.topAnchor
                     .constraint(equalTo: scrollView.topAnchor)
                     .isActive = true
        containerView.leadingAnchor
                     .constraint(equalTo: scrollView.leadingAnchor)
                     .isActive = true
        containerView.trailingAnchor
                     .constraint(equalTo: scrollView.trailingAnchor)
                     .isActive = true
        containerView.bottomAnchor
                     .constraint(equalTo: scrollView.bottomAnchor)
                     .isActive = true
        containerView.widthAnchor
                     .constraint(equalTo: scrollView.widthAnchor)
                     .isActive = true
        
        vStackView.topAnchor
                  .constraint(equalTo: containerView.topAnchor, constant: 12.0)
                  .isActive = true
        vStackView.leadingAnchor
                  .constraint(equalTo: containerView.leadingAnchor, constant: 20.0)
                  .isActive = true
        vStackView.trailingAnchor
                  .constraint(equalTo: containerView.trailingAnchor, constant: -20.0)
                  .isActive = true
        vStackView.bottomAnchor
                  .constraint(equalTo: containerView.bottomAnchor, constant: -12.0)
                  .isActive = true
    }
    
    private func createAnimationLabel() {
        let button = UIButton()
        button.setTitle("產生亂數", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .system_medium_16
        button.backgroundColor = UIColor(hex: "F7685A")
        button.cornerRadius = 8.0
        button.addTarget(self,
                         action: #selector(random(_:)),
                         for: .touchUpInside)
        
        vStackView.addArrangedSubview(animationLabel)
        vStackView.addArrangedSubview(button)
    }
    
    private func createFontLabel() {
        let fonts: [String] = ["Comfortaa-Light", "Comfortaa-Regular", "Comfortaa-Medium",
                               "Comfortaa-SemiBold", "Comfortaa-Bold"]
        let fontStyles: [UIFont.TextStyle] = [.largeTitle, .headline, .body, .title1, .footnote]
        let fontStyleTexts: [String] = ["largeTitle", "headline", "body", "title1", "footnote"]
        
        for i in 0 ..< fonts.count {
            let font = fonts[i]
            let style = fontStyles[i]
            let styleText = fontStyleTexts[i]
            
            let label = UILabel()
            label.text = """
                         Font = \(font)
                         FontStyle = \(styleText)
                         《魷魚遊戲》是於2021年9月17日全球上線的Netflix韓國原創劇，本劇由電影《南漢山城》、《熔爐》的導演黃東赫執導和編劇。講述參與高達456億元韓幣獎金的神祕生存節目所發生的故事。
                         """
            label.textColor = .owlGrayOne
            label.numberOfLines = 0
            
            // TextStyle 不影響顯示
            let fontMetrics = UIFontMetrics(forTextStyle: style)
            label.font = fontMetrics.scaledFont(for: UIFont(name: font, size: 14)!)
            label.adjustsFontForContentSizeCategory = true
            
            vStackView.addArrangedSubview(label)
        }
    }
    
    // MARK: - Action
    
    @objc private func random(_ button: UIButton) {
        let from = Int.random(in: 0 ... 99)
        let to = Int.random(in: 100 ... 1000)
        animationLabel.animate(from: from, to: to, fps: 5)
    }
}
