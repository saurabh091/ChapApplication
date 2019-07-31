//
//  UIviewController+Helpers.swift
//  FirebaseChatApp
//
//  Created by orangemac05 on 31/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController {
    func showLoader() {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.show(withStatus: "Loading...")
    }
    
    func hideLoader(completion: () -> ()) {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
        completion() // notify the caller that the longAction is finished
    }
}
