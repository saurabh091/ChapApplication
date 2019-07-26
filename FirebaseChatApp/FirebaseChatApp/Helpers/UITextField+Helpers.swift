//
//  UITextField+Helpers.swift
//  FirebaseChatApp
//
//  Created by orangemac05 on 26/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func roundCorners(corners:UIRectCorner, radius: Double) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: CGFloat(radius), height: CGFloat(radius)))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.masksToBounds = true
        self.layer.mask = mask
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        self.layer.masksToBounds = true
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func setLeftIcon(_ icon: UIImage) {
        
        let padding = 8
        let size = 20
        
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)
        
        leftView = outerView
        leftViewMode = .always
    }
    
    func leftPadding(marginSize: Double) {
        let padding = marginSize
        let blankView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(padding), height: 10))
        leftView = blankView
        leftViewMode = .always
    }
}
