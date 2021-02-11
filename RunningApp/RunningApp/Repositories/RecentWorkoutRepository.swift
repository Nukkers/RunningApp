//
//  RecentWorkoutRepository.swift
//  RunningApp
//
//  Created by Naukhez Ali on 10/02/2021.
//

import Foundation

class RecentWorkoutRepository {
    private var workoutManager: WorkoutManager?
    var workouts: [Workout] {
        workoutManager?.load() ?? []
    }
    
    init() {}
    
    func loadWorkouts() {
        workoutManager = WorkoutManager()
    }
    
}
