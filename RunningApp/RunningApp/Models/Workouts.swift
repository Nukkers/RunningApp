//
//  Workout.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import Foundation
import Combine

class Workout: Identifiable, Codable {
    var startTime: Date
    var distance: Measurement<UnitLength>
    
    init(distance: Measurement<UnitLength>, startTime: Date) {
        self.distance = distance
        self.startTime = startTime
    }
}

class WorkoutManager: ObservableObject {
    //    var locationCoord: [CLLocation]
    //    var placemark: String
    //    var location: CLLocation
    //    var status: CLAuthorizationStatus
    //    @Published var distance: Measurement<UnitLength>
    //    var startTime: Date
    var workouts: [Workout]
    static let saveKey = "SavedData"
    
    init() {
        self.workouts = []
        self.workouts = load()
         
    }
    
    func load() -> [Workout] {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Workout].self, from: data) {
                self.workouts = decoded
                return self.workouts
            }
        }
        return []
    }
    
    func add(_ newWorkout: Workout) {
        self.workouts.append(newWorkout)
        save()
        print("New workout added succesfully: \(newWorkout.distance) + \(newWorkout.startTime)")
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(self.workouts) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
            print("Workouts saved")
        }
    }
}
