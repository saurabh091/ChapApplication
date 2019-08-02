//
//  User.swift
//  FirebaseChatApp
//
//  Created by orangemac05 on 02/08/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import Foundation

struct User {
    var name:String
    var done: Bool
    var id: String
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "done": done
        ]
    }
}

extension User{
    init?(dictionary: [String : Any], id: String) {
        guard   let name = dictionary["name"] as? String,
            let done = dictionary["done"] as? Bool
            else { return nil }
        
        self.init(name: name, done: done, id: id)
    }
}
