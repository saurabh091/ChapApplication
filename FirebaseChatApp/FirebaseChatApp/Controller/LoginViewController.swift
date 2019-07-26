//
//  LoginViewController.swift
//  FirebaseChatApp
//
//  Created by orangemac05 on 24/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var heightAnchorForContainer: NSLayoutConstraint!
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Logo")
        imgView.contentMode = UIView.ContentMode.scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Login", "Registration"])
        segment.selectedSegmentIndex = 0
        segment.layer.cornerRadius = 8.0
        segment.backgroundColor = .black
        segment.tintColor = .white
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)], for: .normal)
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], for: .selected)
        segment.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.backgroundColor = .white
        tf.leftPadding(marginSize: TextField_Left_Padding)
        tf.setBorder(width: 1.0, color: .gray)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.backgroundColor = .white
        tf.leftPadding(marginSize: TextField_Left_Padding)
        tf.setBorder(width: 1.0, color: .gray)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = .white
        tf.layer.masksToBounds = true
        tf.leftPadding(marginSize: TextField_Left_Padding)
        tf.setBorder(width: 1.0, color: .gray)
        tf.translatesAutoresizingMaskIntoConstraints = false
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
        view.addSubview(segmentControl)
        view.addSubview(imageView)
        
        containerStackView.addArrangedSubview(nameTextField)
        containerStackView.addArrangedSubview(emailTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        setupViewConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.nameTextField.roundCorners(corners: UIRectCorner(arrayLiteral: .topLeft, .topRight), radius: TextField_Corner_Radius)
            self.passwordTextField.roundCorners(corners: UIRectCorner(arrayLiteral: .bottomLeft, .bottomRight), radius: TextField_Corner_Radius)
        }
    }
    
    func setupViewConstraints() {
        containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        heightAnchorForContainer = containerStackView.heightAnchor.constraint(equalToConstant: 150)
        heightAnchorForContainer.isActive = true
        
        segmentControl.centerXAnchor.constraint(equalTo: containerStackView.centerXAnchor).isActive = true
        segmentControl.bottomAnchor.constraint(equalTo: containerStackView.topAnchor, constant: -10).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: containerStackView.widthAnchor, multiplier: 1.0).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: containerStackView.centerXAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: segmentControl.topAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor, multiplier: 0.5).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        changeLoginTabs(selectedIndex: index)
    }
}
extension LoginViewController {
    func changeLoginTabs(selectedIndex: Int) {
        if selectedIndex == 0 {
            self.emailTextField.isHidden = true
            UIView.animate(withDuration: 0.5) {
                self.heightAnchorForContainer.constant = 100
            }
        }else {
            self.emailTextField.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.heightAnchorForContainer.constant = 150
            }
        }
    }
}

