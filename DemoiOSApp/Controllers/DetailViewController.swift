//
//  DetailViewController.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 15/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var detailTxt: UITextView!
    
    var titleVal: String?
    var myImage : UIImage?
    var descTxt : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setup()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        
        self.navigationItem.title = titleVal
        imgView.layer.cornerRadius = imgView.frame.width / 2
        imgView.image = myImage
        detailTxt.text = descTxt
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
