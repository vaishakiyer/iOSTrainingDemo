//
//  ListViewController.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 15/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import UIKit

struct MyObject{
    
    var title: String
    var description : String
    var image: UIImage
    
}

class ListViewController: UIViewController {
    
    var userObject = [MyObject]()

    @IBOutlet weak var listTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTable.delegate = self
        listTable.dataSource = self
        
        let tempImageView = UIImageView(image: UIImage(named: "A ship in Balestrand"))
        tempImageView.frame = self.listTable.frame
        self.listTable.backgroundView = tempImageView;
        listTable.separatorStyle = .none
        
        listTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }
    
    func createEmptyText(message: String){
      
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.white
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        listTable.backgroundView = messageLabel;
        listTable.separatorStyle = .none;
    
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

extension ListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return userObject.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "  "
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = userObject[indexPath.section].title
        cell.imageView?.image = userObject[indexPath.section].image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        vc?.myImage = userObject[indexPath.section].image
        vc?.descTxt = userObject[indexPath.section].description
        vc?.titleVal = userObject[indexPath.section].title
        
        self.navigationController?.pushViewController(vc!
            , animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        let indexSet = IndexSet(arrayLiteral: indexPath.section)
        if editingStyle == .delete{
            userObject.remove(at: indexPath.section)
            listTable.deleteSections(indexSet, with: .fade)
        }
        
    }
}


