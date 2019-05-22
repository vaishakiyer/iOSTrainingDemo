//
//  GalleryViewController.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 20/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import UIKit
import Alamofire


class GalleryViewController: UIViewController {
    
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    
    var queue = OperationQueue()
    
    let imagesToDownload =  [
        "https://www.planetware.com/photos-large/USIL/illinois-chicago-art-institute.jpg",
        "https://www.planetware.com/photos-large/USIL/illinois-chicago-millenium-park.jpg",
        "http://s1.ax1x.com/2017/12/06/oaiz8.png",
        "https://www.planetware.com/photos-large/USAZ/arizona-monument-valley-buttes-and-red-sand.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startOprPressed(_ sender: UIButton) {
        
        let operation1 = BlockOperation{
            let img1 =  self.downloader(imgName: self.imagesToDownload[0])
            OperationQueue.main.addOperation {
                self.img1.image = img1
            }
        }
        
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation{
            let img1 =  self.downloader(imgName: self.imagesToDownload[1])
            OperationQueue.main.addOperation {
                self.img2.image = img1
            }
        }
        
        queue.addOperation(operation2)
        
        let operation3 = BlockOperation{
            let img1 =  self.downloader(imgName: self.imagesToDownload[2])
            OperationQueue.main.addOperation {
                self.img3.image = img1
            }
        }
        
        queue.addOperation(operation3)
        
        let operation4 = BlockOperation{
            let img1 =  self.downloader(imgName: self.imagesToDownload[3])
            OperationQueue.main.addOperation {
                self.img4.image = img1
            }
        }
        
        queue.addOperation(operation4)
        
        
    }
    
    @IBAction func cancelOprPressed(_ sender: UIButton) {
        
        
        
    }
    
    
    func downloader(imgName: String) -> UIImage{
        
        let data = try? Data(contentsOf: URL(string: imgName)!)
        return UIImage(data: data!)!
        
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
