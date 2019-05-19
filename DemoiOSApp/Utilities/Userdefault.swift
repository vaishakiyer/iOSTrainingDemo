//
//  Userdefault.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 15/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import Foundation

private let kToken = "kToken"
private let kUser = "kUser"

class Userdefault{
    
    static let sharedInstance = UserDefaults.standard
    
    
    class func setToken(token: String){
        
        sharedInstance.set(token, forKey: kToken)
        sharedInstance.synchronize()
    }
    
    class func getToken() -> String?{
        return sharedInstance.value(forKey: kToken) as? String
    }
    
    class func clearToken() {
        
        sharedInstance.removeObject(forKey: kToken)
        sharedInstance.synchronize()
    }
    
    class func setLoggedInUserDict(_ userDict: NSDictionary) {
        sharedInstance.set(try? NSKeyedArchiver.archivedData(withRootObject: userDict, requiringSecureCoding: true), forKey: kUser)
        sharedInstance.synchronize()
    }
    
    class func loggedInUser() -> User? {
        let data = Foundation.UserDefaults.standard.object(forKey: kUser) as! Data
        let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSDictionary
        return User(JSON: object!)
    }
    
    class func removeUserObj(){
        sharedInstance.removeObject(forKey: kUser)
        sharedInstance.synchronize()
    }
    
}
