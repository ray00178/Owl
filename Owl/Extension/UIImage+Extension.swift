//
//  UIImage+Extension.swift
//  Owl
//
//  Created by Ray on 2021/11/8.
//

import UIKit

// MARK: - Crop

extension UIImage {
    
    /// 裁減圖片 reference: https://developer.apple.com/documentation/coregraphics/cgimage/1454683-cropping
    /// - Parameter rect: 裁減範圍
    
    ///  裁減圖片
    /// - Parameter rect: 裁減範圍
    /// - Reference: https://developer.apple.com/documentation/coregraphics/cgimage/1454683-cropping
    func crop(to rect: CGRect) -> UIImage {
        guard let cgImage = self.cgImage else { return self }
                
        guard let cropImage = cgImage.cropping(to: rect) else { return self }
                
        let scale = UIScreen.main.scale
        let image = UIImage(cgImage: cropImage, scale: scale, orientation: .up)
                
//        #if targetEnvironment(simulator)
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        #endif
                
        return image
    }
}
