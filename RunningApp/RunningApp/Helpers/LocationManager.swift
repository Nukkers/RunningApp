//
//  LocationManager.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func geocode()
    
    var distance: Measurement<UnitLength> { get }
    var locationList: [CLLocation] { get }
    var location: CLLocation? { get }
    var placemark: CLPlacemark? { get }
    var locationManager: CLLocationManager { get }
    
}

class LocationManager: NSObject, LocationManagerProtocol{
    
    let locationManager: CLLocationManager
    private let geocoder = CLGeocoder()
    
    var status: CLAuthorizationStatus?
    var distance = Measurement(value: 0, unit: UnitLength.meters)
    var locationList: [CLLocation] = []
    var location: CLLocation?
    var placemark: CLPlacemark?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
    }
    
    func startUpdatingLocation() {
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        locationList.removeAll()
        
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    internal func geocode() {
        guard let location = self.location else { return }
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        })
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10
            else  { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            }
            
            locationList.append(newLocation)
            self.location = newLocation
        }
        self.geocode()
    }
}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }
    
    var longitude: Double {
        return self.coordinate.longitude
    }
}
