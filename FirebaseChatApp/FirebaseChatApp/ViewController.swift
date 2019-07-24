//
//  ViewController.swift
//  FirebaseChatApp
//
//  Created by orangemac05 on 24/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout() {
        let loginView = LoginViewController()
        present(loginView, animated: true, completion: nil)
    }
}

