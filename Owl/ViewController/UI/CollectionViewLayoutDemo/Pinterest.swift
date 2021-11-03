//
//  Pinterest.swift
//  Owl
//
//  Created by Ray on 2021/9/28.
//

import UIKit

/// PinterestVC Model
struct Pinterest {
    
    private(set) var image: UIImage?
    
    private(set) var title: String?
    
    init() {}
    
    init(path: String?, title: String?) {
        if let path = path {
            image = UIImage(contentsOfFile: path)
        }
        
        self.title = title
    }
}
