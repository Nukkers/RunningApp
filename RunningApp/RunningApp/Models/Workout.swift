//
//  Workout.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import Foundation
import Combine

class Workout: ObservableObject {
//    var locationCoord: [CLLocation]
//    var placemark: String
//    var location: CLLocation
//    var status: CLAuthorizationStatus
    @Published var distance: Measurement<UnitLength>
    var startTime: Date
    
    init(distance: Measurement<UnitLength>, startTime: Date) {
        self.distance = distance
        self.startTime = startTime
    }
}
