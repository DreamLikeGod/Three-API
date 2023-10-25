//
//  ViewController.swift
//  apiNetworking
//
//  Created by Егор on 23.10.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
           
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations.last! as CLLocation
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            ApiManager.shared.getWeather(with: center) { weather in
                print(weather ?? "LUL")
            }
        }


}

