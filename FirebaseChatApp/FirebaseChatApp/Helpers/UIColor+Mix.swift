//
//  UIColor+Mix.swift
//  FirebaseChatApp
//
//  Created by orangemac05 on 26/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1)
    }
}
