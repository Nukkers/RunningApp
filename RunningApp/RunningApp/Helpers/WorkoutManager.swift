//
//  WorkoutManager.swift
//  RunningApp
//
//  Created by Naukhez Ali on 17/02/2021.
//

import Foundation

class WorkoutManager: ObservableObject {

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
