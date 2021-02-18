//
//  LocationManagerAdapter.swift
//  RunningApp
//
//  Created by Naukhez Ali on 17/02/2021.
//

import Foundation
import CoreLocation

class LocationManagerAdapter {
    
    func convertPlacemark(place: CLPlacemark) -> String  {
        guard let place = place.name else { return "" }
        return place
    }
    
    func convertCLLocationToWorkoutLocation(cllocations: [CLLocation]) -> [WorkoutLocation] {
        
        var workoutLocation = [WorkoutLocation]()
        
        for cllocation in cllocations {
            let workout = WorkoutLocation(lat: cllocation.coordinate.latitude, long: cllocation.coordinate.longitude)
            workoutLocation.append(workout)
        }
        
        return workoutLocation
    }
    
    func convertLocationToWorkoutLocation(location: CLLocation) -> WorkoutLocation {
        let workoutLocation = WorkoutLocation(lat: location.latitude, long: location.longitude)
        
        return workoutLocation
    }
}
