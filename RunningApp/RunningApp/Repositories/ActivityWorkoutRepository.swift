//
//  ActivityWorkoutRepository.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import Foundation

protocol ActivityWorkoutRepositoryProtocol {
    var locationManager: LocationManager? { get set }
    func startWorkout()
    func stopWorkout()
}

class ActivityWorkoutRepository: ActivityWorkoutRepositoryProtocol {
    var locationManager: LocationManager?
    let locationManagerAdapter = LocationManagerAdapter()
    
    var distance: Measurement<UnitLength> {
        locationManager?.distance ?? Measurement(value: 0, unit: UnitLength.meters)
    }
    
    var locationCoord: [WorkoutLocation] {
        
        guard let locationList = locationManager?.locationList else { return []}
        
        return locationManagerAdapter.convertCLLocationToWorkoutLocation(cllocations: locationList)
    }
    
    var location: WorkoutLocation? {
        
        guard let location = locationManager?.location else { return nil}
        
        return locationManagerAdapter.convertLocationToWorkoutLocation(location: location)
    }
    
    var placemark: String? {
        guard let placemark = locationManager?.placemark else { return nil }
        return locationManagerAdapter.convertPlacemark(place: placemark)
    }
    
    init() {}
    
    func startWorkout() {
        locationManager = LocationManager()
    }
    
    func stopWorkout() {
        locationManager?.stopUpdatingLocation()
    }
}
