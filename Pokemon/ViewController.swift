//
//  ViewController.swift
//  Pokemon
//
//  Created by Victor Zambrano on 3/8/17.
//  Copyright © 2017 Angelzzz23. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var updateCount = 0
    var manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        manager.delegate = self
        
        if  CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("Ready")
              mapView.showsUserLocation = true
              manager.startUpdatingLocation()
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                //spawn a pokemon 
                
               if let coord = self.manager.location?.coordinate {
               let anno = MKPointAnnotation()
                anno.coordinate = coord
                let randoLat = (Double(arc4random_uniform(200)) - 100.0 ) / 500000.0
                let randolon = (Double(arc4random_uniform(200)) - 100.0 ) / 500000.0
                anno.coordinate.latitude += randoLat //ramdomness
                 anno.coordinate.longitude += randolon
                   self.mapView.addAnnotation(anno)
                }
                
            })
            
            
        }else {
             manager.requestWhenInUseAuthorization()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { //setting location
      
        if updateCount < 3 { //stops animatio
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate,  200, 200)
            mapView.setRegion(region, animated: false) //setting it
            updateCount += 1
        }else {
            manager.stopUpdatingLocation()
        }

    }
    
    @IBAction func centerTapped(_ sender: Any) {
        if let coord = manager.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coord,  200, 200)
            mapView.setRegion(region, animated: false) //setting it
            
        }
   
    }
    
}

