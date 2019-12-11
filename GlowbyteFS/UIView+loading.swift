//
//  UIView+loading.swift
//  GlowbyteFS
//
//  Created by Kirill on 29.11.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import Foundation
import UIKit

private var activityIndicatorViewAssociativeKey = "ActivityIndicatorViewAssociativeKey"

extension UIView {
    var activityIndicatorView: UIActivityIndicatorView {
        get {
            if let activityIndicatorView = objc_getAssociatedObject(self,
                                                                    &activityIndicatorViewAssociativeKey) as? UIActivityIndicatorView {
                return activityIndicatorView
            } else {
                let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                activityIndicatorView.style = .whiteLarge
                activityIndicatorView.color = .gray
                activityIndicatorView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2) //center
                activityIndicatorView.hidesWhenStopped = true
                addSubview(activityIndicatorView)

                objc_setAssociatedObject(self, &activityIndicatorViewAssociativeKey,
                                         activityIndicatorView,
                                         .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return activityIndicatorView
            }
        }

        set {
            addSubview(newValue)
            objc_setAssociatedObject(self, &activityIndicatorViewAssociativeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

    }
}
