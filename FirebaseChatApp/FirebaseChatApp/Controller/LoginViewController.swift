//
//  LoginViewController.swift
//  FirebaseChatApp
//
//  Created by orangemac05 on 24/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var ref: DatabaseReference!
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
        tf.returnKeyType = .next
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.backgroundColor = .white
        tf.leftPadding(marginSize: TextField_Left_Padding)
        tf.setBorder(width: 1.0, color: .gray)
        tf.returnKeyType = .next
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
        tf.returnKeyType = .done
        tf.autocorrectionType = .no
        tf.isSecureTextEntry = true
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
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5.0
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: UIFont.Weight(rawValue: 3))
        button.backgroundColor = .white
        button.setTitleColor(UIColor(r: 61, g: 91, b: 151), for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        ref = Database.database().reference(fromURL: "https://fir-chatapp-121f9.firebaseio.com")
        view.addSubview(containerStackView)
        view.addSubview(segmentControl)
        view.addSubview(imageView)
        view.addSubview(loginRegisterButton)
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.tag = 1
        emailTextField.tag = 2
        passwordTextField.tag = 3
        
        containerStackView.addArrangedSubview(nameTextField)
        containerStackView.addArrangedSubview(emailTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        setupViewConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.nameTextField.roundCorners(corners: UIRectCorner(arrayLiteral: .topLeft, .topRight), radius: TextField_Corner_Radius)
            self.passwordTextField.roundCorners(corners: UIRectCorner(arrayLiteral: .bottomLeft, .bottomRight), radius: TextField_Corner_Radius)
        }
        
        changeLoginTabs(selectedIndex: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        //        let keyBoardSize = ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue)
        
        UIView.animate(withDuration: 0.3) {
            var frame = self.view.frame
            frame.origin.y = CGFloat(Keyboard_Height)
            self.view.frame = frame
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        changeLoginTabs(selectedIndex: index)
    }
    
    @objc func submitAction() {
        guard let name = nameTextField.text ,let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error as Any)
            }
            print(result as Any)
            
            guard let uid = result?.user.uid else {
                return
            }
            
            // successfully authenticated user
            let userRefrence = self.ref.child("ChatUsers").child(uid)
            let values = ["name": name, "email": email, "password": password]
            userRefrence.updateChildValues(values, withCompletionBlock: { (error, ref) in
                guard let err = error else {
                    print("Save successfully")
                    return
                }
                
                print(err)
            })
        }
        
        
    }
}

extension LoginViewController {
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
        
        loginRegisterButton.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 10).isActive = true
        loginRegisterButton.centerXAnchor.constraint(equalTo: containerStackView.centerXAnchor).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: containerStackView.widthAnchor, constant: 1.0).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func changeLoginTabs(selectedIndex: Int) {
        if selectedIndex == 0 {
            emailTextField.isHidden = true
            loginRegisterButton.setTitle("Log In", for: .normal)
            passwordTextField.tag = 2
            emailTextField.tag = 10
            UIView.animate(withDuration: 0.5) {
                self.heightAnchorForContainer.constant = 100
            }
        }else {
            emailTextField.isHidden = false
            loginRegisterButton.setTitle("Register", for: .normal)
            passwordTextField.tag = 3
            emailTextField.tag = 2
            UIView.animate(withDuration: 0.5) {
                self.heightAnchorForContainer.constant = 150
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {  //delegate method
        return true
    }
    
    // MARK: - Search Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
}

