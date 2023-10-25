//
//  CoordinatedManager.swift
//  apiNetworking
//
//  Created by Егор on 25.10.2023.
//

import Foundation
import CoreLocation

class CoordinatedManager: CLLocationManagerDelegate {
    func isEqual(_ object: Any?) -> Bool {
        return true
    }
    
    var hash: Int = 0
    
    var superclass: AnyClass?
    
    func `self`() -> Self {
        return self
    }
    
    func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>! {
        return aSelector as! Unmanaged<AnyObject>?
    }
    
    func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>! {
        return aSelector as! Unmanaged<AnyObject>?
    }
    
    func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>! {
        return aSelector as! Unmanaged<AnyObject>?
    }
    
    func isProxy() -> Bool {
        return true
    }
    
    func isKind(of aClass: AnyClass) -> Bool {
        return true
    }
    
    func isMember(of aClass: AnyClass) -> Bool {
        return true
    }
    
    func conforms(to aProtocol: Protocol) -> Bool {
        return true
    }
    
    func responds(to aSelector: Selector!) -> Bool {
        return true
    }
    
    var description: String = ""
    
    
    public static let shared = CoordinatedManager()
    
    var locationManager: CLLocationManager {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        return locationManager
    }
    
    public func locationManager(_ manager: CLLocationManager = CoordinatedManager.shared.locationManager, didUpdateLocations locations: [CLLocation] = [CoordinatedManager.shared.locationManager.location!]) -> CLLocationCoordinate2D {
        return manager.location!.coordinate
    }
    
    
}
