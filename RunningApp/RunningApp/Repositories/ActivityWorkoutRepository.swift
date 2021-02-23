//
//  ActivityWorkoutRepository.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import Foundation

protocol ActivityWorkoutRepositoryProtocol {
    var distance: Measurement<UnitLength> { get }
    var locationCoord: [WorkoutLocation] { get }
    var location: WorkoutLocation? { get }
    var placemark: String? { get }
    func startWorkout()
    func stopWorkout()
}

class ActivityWorkoutRepository: ActivityWorkoutRepositoryProtocol {
    private var locationManager: LocationManagerProtocol?
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
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
    }
    
    func startWorkout() {
        guard let locationManager = locationManager else { return }
        locationManager.startUpdatingLocation()
    }
    
    func stopWorkout() {
        guard let locationManager = locationManager else { return }
        locationManager.stopUpdatingLocation()
    }
}
