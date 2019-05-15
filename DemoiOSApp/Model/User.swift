//
//  User.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 15/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import Foundation

class User{
    
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String
    
    
    init(JSON: NSDictionary) {
        self.email = JSON.value(forKey: "email") as! String
        self.firstName = JSON.value(forKey: "first_name") as! String
        self.lastName = JSON.value(forKey: "last_name") as! String
        self.avatar = JSON.value(forKey: "avatar") as! String
    }
    
}
