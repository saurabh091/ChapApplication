//
//  LoginViewController.swift
//  FirebaseChatApp
//
//  Created by orangemac05 on 24/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.backgroundColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .white
        return tf
    }()
    
    let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 61/255, green: 91/255, blue: 151/255, alpha: 1)
        
        view.addSubview(containerStackView)
        containerStackView.addArrangedSubview(nameTextField)
        containerStackView.addArrangedSubview(emailTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        
        setupViewConstraints()
    }
    
    func setupViewConstraints() {
        containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        containerStackView.heightAnchor.constraint(equalToConstant: 150)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1)
    }
}
