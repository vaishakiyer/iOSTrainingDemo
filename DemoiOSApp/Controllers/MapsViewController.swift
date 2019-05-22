//
//  MapsViewController.swift
//  DemoiOSApp
//
//  Created by Vaishak Iyer on 22/05/19.
//  Copyright © 2019 Vaishak Iyer. All rights reserved.
//

import UIKit
import GoogleMaps


class MapsViewController: UIViewController{
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationRequest()
        self.navigationItem.title = "Google Maps"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissMe))
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissMe(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setLocationRequest(){
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
    }
    
    
    func setupMaps(lat: Double,long: Double){
        
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            guard let placemarkPos = placemarks?.first else {return}
            marker.title = placemarkPos.subLocality
            marker.snippet = placemarkPos.locality
        }
        
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

extension MapsViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        setupMaps(lat: locValue.latitude, long: locValue.longitude)
        //  print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
}
