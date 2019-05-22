//
//  HomeTabViewController.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 15/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class HomeTabViewController: UITabBarController {
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        let mapsButton = UIBarButtonItem(title: "Maps", style: .done, target: self, action: #selector(openMaps))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(navigate))
        self.navigationItem.rightBarButtonItems = [addButton,mapsButton]
        
        self.navigationItem.title = "List of Random Items"
        
        fetchUser()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func navigate(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddItemViewController") as! AddItemViewController
        vc.delegate = self
        let nc = UINavigationController.init(rootViewController: vc)
        self.present(nc, animated: true, completion: nil)
    }
    
    @objc func openMaps(){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        var vc: UIViewController?
        
        vc = storyBoard.instantiateViewController(withIdentifier: "MapsViewController")
        let nc = UINavigationController.init(rootViewController: vc!)
        self.present(nc, animated: true, completion: nil)
        
    }
    
    func fetchUser(){
        
        AF.request(URL(string: "https://reqres.in/api/users/2")!).responseJSON { (response) in
            
            switch response.result{
                
            case .success(let JSON):
                print(JSON)
                
                guard let myData = (JSON as? NSDictionary)?.value(forKey: "data") as? NSDictionary else {return}
                Userdefault.setLoggedInUserDict(myData)
                
            case .failure(let error):
                print(error)
            }
            
            
        }
        
        
        
        
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

extension HomeTabViewController: SendData,UITabBarControllerDelegate{
    func valuesToBePopulated(object: MyObject) {
        
        let listVC = self.viewControllers?.first as? ListViewController
        listVC?.userObject.append(object)
        let saveObjects = ListService(context: self.context!)
        
        if let imgData = object.image.pngData(){
            
            saveObjects.create(title: object.title, desc: object.description, image: imgData)
            saveObjects.saveChanges()
        }
        
        listVC?.listTable.reloadData()
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        if tabBarController.selectedIndex == 0{
            self.navigationItem.title = "List of Random Items"
        }else  if tabBarController.selectedIndex == 1{
            self.navigationItem.title = "My Profile"
        }else{
            self.navigationItem.title = "Gallery"
        }
        
    }
    
    
}
