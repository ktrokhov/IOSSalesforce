//
//  UIImage+resize.swift
//  GlowbyteFS
//
//  Created by Kirill on 02.12.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

extension UIImage {
    func resizedByHalf() -> UIImage {
        let newSize = CGSize(width: self.size.width * 0.5, height: self.size.height * 0.5)
        let rect = CGRect(origin: .zero, size: newSize)

        // resize the image
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }
}
