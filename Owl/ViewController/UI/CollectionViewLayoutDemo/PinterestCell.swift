//
//  PinterestCell.swift
//  Owl
//
//  Created by Ray on 2021/9/28.
//

import UIKit

class PinterestCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var data: Pinterest? {
        didSet { reloadContent() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup() {
        photoImageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = .white
        titleLabel.font = .system_medium_16
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = UIColor(hex: "000000", alpha: 0.65)
        
        cornerRadius = 8.0
    }
    
    /// 刷新內容
    private func reloadContent() {
        photoImageView.image = data?.image
        titleLabel.text = data?.title
    }
}
