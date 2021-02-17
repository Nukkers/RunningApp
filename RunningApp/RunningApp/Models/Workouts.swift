//
//  Workout.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import Foundation

class Workout: Identifiable, Codable {
    var distance: Measurement<UnitLength>
    var startTime: Date
    var locationCoord: [WorkoutLocation] = []
    var location: WorkoutLocation?
    var placemark: String?
    
    init(distance: Measurement<UnitLength>, startTime: Date, locationCoords: [WorkoutLocation], placemark: String,
         location: WorkoutLocation) {
        self.distance = distance
        self.startTime = startTime
        self.locationCoord = locationCoords
        self.placemark = placemark
        self.location = location
        
    }
}

struct WorkoutLocation: Codable {
    var latitude: Double
    var longitude: Double
    
    init(lat: Double, long: Double) {
        self.latitude = lat
        self.longitude = long
    }
}
