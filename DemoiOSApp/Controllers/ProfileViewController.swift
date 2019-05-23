//
//  ProfileViewController.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 15/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var emailLogged: UILabel!
    
    @IBOutlet weak var firstNameLogged: UILabel!
    
    @IBOutlet weak var lastNameLogged: UILabel!
    
    @IBOutlet weak var signOutBtn: UIButton!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = Userdefault.loggedInUser()
        setup()
        // Do any additional setup after loading the view.
    }
    
    
    func setup(){
        
        
        avatar.layer.cornerRadius = avatar.frame.width / 2
        signOutBtn.addTarget(self, action: #selector(signOutPressed), for: .touchUpInside)
        signOutBtn.layer.cornerRadius = 10
        avatar.clipsToBounds = true
        loadData()
        
    }
    
    func loadData(){
        
        Spinner.start(style: .whiteLarge, backColor: .clear, baseColor: .white)
        
        AF.request(URL(string: user!.avatar)!).response { (response) in
            
            Spinner.stop()
            self.avatar.image = UIImage(data: response.data!)
        }
        emailLogged.text = user?.email
        firstNameLogged.text = user?.firstName
        lastNameLogged.text = user?.lastName
    }
    
    
    @objc func signOutPressed(){
        
        Userdefault.clearToken()
        Userdefault.removeUserObj()
        self.dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
