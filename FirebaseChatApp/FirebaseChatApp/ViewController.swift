//
//  ViewController.swift
//  FirebaseChatApp
//
//  Created by orangemac05 on 24/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ViewController: UIViewController {
    
    var users: [QueryDocumentSnapshot] = []
    
    private lazy var userTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showLoader()
        users.removeAll()
        readDbData()
    }
    
    func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        userTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(userTableView)
    }
    
    func setupViewConstraints() {
        let margins = view.safeAreaLayoutGuide
        userTableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        userTableView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0).isActive = true
        userTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
        userTableView.rightAnchor.constraint(equalTo: margins .rightAnchor, constant: 0).isActive = true
    }
    
    @objc func handleLogout() {
        let loginView = LoginViewController()
        present(loginView, animated: true, completion: nil)
    }
    
    func readDbData() {
        let db = Firestore.firestore()
        db.collection("ChatUsers").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.users.append(document)
                }
                self.reloadTable()
                self.hideLoader {}
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func reloadTable() {
        userTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = users[indexPath.row].get("name") as? String
        return cell!
    }
}

