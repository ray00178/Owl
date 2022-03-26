//
//  AppContainerVC.swift
//  Owl
//
//  Created by Ray on 2021/9/8.
//

import UIKit

class AppContainerVC: AppBaseVC {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.registerCell(AppContainerCell.self, fromNib: false)
        tableView.rowHeight = 100.0
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.useAutoLayout = true
        return tableView
    }()
    
    private var appTab: AppManager.AppTab?
    
    private var dataset: [Page] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        createDataset()
    }
    
    private func setup() {
        navigationItem.title = appTab?.title
        view.backgroundColor = .owlBackground
        view.addSubview(tableView)
        
        autoLayout()
    }
    
    private func createDataset() {
        switch appTab {
        case .ui:
            dataset = [.collectionViewLayout, .compositionalLayout, .fontAndAnimation,
                       .cropImage, .qrCode, .tabSwipe]
        case .network:
            dataset = [.apiDemo1]
        case .other:
            break
        case .setting:
            break
        default:
            break
        }
    }
    
    private func autoLayout() {
        tableView.topAnchor
                 .constraint(equalTo: view.topAnchor)
                 .isActive = true
        tableView.leadingAnchor
                 .constraint(equalTo: view.leadingAnchor)
                 .isActive = true
        tableView.trailingAnchor
                 .constraint(equalTo: view.trailingAnchor)
                 .isActive = true
        tableView.bottomAnchor
                 .constraint(equalTo: view.bottomAnchor)
                 .isActive = true
    }
    
    private func showErrorAlert(message: String?) {
        let ac = UIAlertController(title: message,
                                   message: nil,
                                   preferredStyle: .alert)
        let action = UIAlertAction(title: "我知道了", style: .default, handler: nil)
    
        ac.addAction(action)
        ac.view.tintColor = .owlMain
        
        present(to: ac, style: .fullScreen, animated: true, completion: nil)
    }
}

extension AppContainerVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataset.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(AppContainerCell.self)
        cell.data = dataset.safeGet(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let page = dataset.safeGet(indexPath.row)
        switch page {
        case .collectionViewLayout:
            let vc = PinterestVC()
            vc.page = page
            setCustomNavigationItemBack(title: "")
            push(to: vc, animated: true)
        case .compositionalLayout:
            if #available(iOS 13.0, *) {
                let vc = CompositionalLayoutVC()
                vc.page = page
                setCustomNavigationItemBack(title: appTab?.title)
                push(to: vc, animated: true)
            } else {
                showErrorAlert(message: "該功能Demo僅在iOS 13.0以上可使用！")
            }
        case .fontAndAnimation:
            let vc = FontAndAnimationDemoVC()
            vc.page = page
            setCustomNavigationItemBack(title: appTab?.title)
            push(to: vc, animated: true)
        case .cropImage:
            let vc = CropImageDemoVC(nibName: "CropImageDemoVC", bundle: nil)
            vc.page = page
            setCustomNavigationItemBack(title: appTab?.title)
            push(to: vc, animated: true)
        case .apiDemo1:
            let vc = ApiDemo1VC()
            vc.page = page
            setCustomNavigationItemBack(title: "")
            push(to: vc, animated: true)
        case .imageLoader:
            let vc = ImageLoaderDemoVC()
            vc.page = page
            setCustomNavigationItemBack(title: appTab?.title)
            push(to: vc, animated: true)
        default:
            break
        }
    }
}

// MARK: - Convenience

extension AppContainerVC {
    
    convenience init(appTab: AppManager.AppTab) {
        self.init()
        self.appTab = appTab
    }
}

// MARK: - AppContainerCell

extension AppContainerVC {
    
    class AppContainerCell: UITableViewCell {
    
        private lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = .owlCellBackground
            view.cornerRadius = 8.0
            view.useAutoLayout = true
            return view
        }()
        
        private lazy var iconImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.useAutoLayout = true
            return imageView
        }()
        
        private lazy var label: UILabel = {
            let label = UILabel()
            label.font = .system_medium_18
            label.textColor = .owlMain
            label.numberOfLines = 0
            label.useAutoLayout = true
            return label
        }()
        
        var data: Page? {
            didSet { setData() }
        }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
     
        private func setup() {
            contentView.backgroundColor = .clear
            backgroundColor = .clear
            selectionStyle = .none
            
            contentView.addSubview(containerView)
            containerView.addSubview(iconImageView)
            containerView.addSubview(label)
            
            autoLayout()
        }
        
        private func autoLayout() {
            containerView.topAnchor
                         .constraint(equalTo: contentView.topAnchor, constant: 12.0)
                         .isActive = true
            containerView.leadingAnchor
                         .constraint(equalTo: contentView.leadingAnchor, constant: 12.0)
                         .isActive = true
            containerView.trailingAnchor
                         .constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
                         .isActive = true
            containerView.bottomAnchor
                         .constraint(equalTo: contentView.bottomAnchor, constant: -12.0)
                         .isActive = true
            
            iconImageView.leadingAnchor
                         .constraint(equalTo: containerView.leadingAnchor, constant: 16.0)
                         .isActive = true
            iconImageView.centerYAnchor
                         .constraint(equalTo: containerView.centerYAnchor)
                         .isActive = true
            iconImageView.widthAnchor
                         .constraint(equalToConstant: 24.0)
                         .isActive = true
            iconImageView.heightAnchor
                         .constraint(equalToConstant: 24.0)
                         .isActive = true
            
            label.topAnchor
                 .constraint(equalTo: containerView.topAnchor, constant: 8.0)
                 .isActive = true
            label.leadingAnchor
                 .constraint(equalTo: iconImageView.trailingAnchor, constant: 12.0)
                 .isActive = true
            label.trailingAnchor
                 .constraint(equalTo: containerView.trailingAnchor, constant: -16.0)
                 .isActive = true
            label.bottomAnchor
                 .constraint(equalTo: containerView.bottomAnchor, constant: -8.0)
                 .isActive = true
        }
        
        private func setData() {
            iconImageView.image = data?.icon
            label.text = data?.title
        }
    }
}

// MARK: - Enum

extension AppContainerVC {
    
    enum Page {
        
        case collectionViewLayout
        
        case compositionalLayout
        
        case fontAndAnimation
        
        case cropImage
                
        case qrCode
        
        case tabSwipe
        
        case apiDemo1
        
        case imageLoader
        
        var title: String? {
            switch self {
            case .collectionViewLayout:
                return "Custom CollectionView Layout"
            case .compositionalLayout:
                return "Compositional Layout"
            case .fontAndAnimation:
                return "Font Style, Animation Number"
            case .cropImage:
                return "Crop Image"
            case .qrCode:
                return "QRCode Scan"
            case .tabSwipe:
                return "Tap Swipe with scroll view"
            case .apiDemo1:
                return "Api Demo 1"
            case .imageLoader:
                return "Image Loader"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .collectionViewLayout, .compositionalLayout, .fontAndAnimation,
                 .cropImage, .qrCode,
                 .tabSwipe:
                return UIImage(named: "ic-ui-full")
            case .apiDemo1, .imageLoader:
                return UIImage(named: "ic-network-full")
            }
        }
    }
    
}
