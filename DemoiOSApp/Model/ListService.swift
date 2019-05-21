//
//  ListService.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 16/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ListService{
    
    var context: NSManagedObjectContext
    var entity: NSEntityDescription
    
    init(context: NSManagedObjectContext) {
        
        self.context = context
        self.entity = NSEntityDescription.entity(forEntityName: "Topic", in: context)!
    }
    
    
    func create(title: String,desc: String,image: Data){
        
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Topic", into: context) as? Topic
        newItem?.titleName = title
        newItem?.descName = desc
        newItem?.myimage = image
        
        //return newItem!
    }
    
   
    
    func delete(object: MyObject){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Topic")
    
        do {
            
            let response = try context.fetch(fetchRequest) as? [Topic]
            response?.forEach({ (topic) in
                if topic.titleName == object.title{
                    context.delete(topic)
                }
            })
            
            
        } catch let error as NSError {
            
            print(error)
            
        }
        
       
        
    }
    
    func saveChanges(){
        do{
            try context.save()
        } catch let error as NSError {
            // failure
            print(error)
        }
    }

    
    func get(withPredicate queryPredicate: NSPredicate) -> [Topic]{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Topic")
        
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [Topic]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Topic]()
        }
    }
    
    func getAll() -> [MyObject]{
        
        let ObjArray = get(withPredicate: NSPredicate(value:true))
        
        var returnObject = [MyObject]()
        
        for items in ObjArray{
            
            let obj = MyObject(title: items.titleName!, description: items.descName!, image: UIImage(data: items.myimage!)!)
            
            returnObject.append(obj)
        }
        
        return returnObject
    }
}
