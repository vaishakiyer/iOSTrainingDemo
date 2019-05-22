//
//  MapsViewController.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 22/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMaps()
        self.navigationItem.title = "Google Maps"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissMe))
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissMe(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupMaps(){
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
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
