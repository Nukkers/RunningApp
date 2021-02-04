//
//  ActivityWorkoutRepository.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import Foundation

class ActivityWorkoutRepository {
    
    private var locationManager: LocationManager?
    var distance: Measurement<UnitLength> {
        locationManager?.distance ?? Measurement(value: 0, unit: UnitLength.meters)
    }

    init() {}
    
    func startWorkout() {
        locationManager = LocationManager()
    }
}

