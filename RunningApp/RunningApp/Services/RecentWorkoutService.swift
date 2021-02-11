//
//  RecentWorkoutService.swift
//  RunningApp
//
//  Created by Naukhez Ali on 10/02/2021.
//

import Foundation

protocol RecentWorkoutAddedDelegate: class {
    func recentWorkoutDidUpdate(workouts: [Workout])
}

class RecentWorkoutService {
    
    private var recentWorkoutRepo: RecentWorkoutRepository
    
    weak var recentWorkoutAddedDelegate: RecentWorkoutAddedDelegate?
    
    init(recentWorkoutRepo: RecentWorkoutRepository) {
        self.recentWorkoutRepo = recentWorkoutRepo
    }
    
    func getRecentWorkouts() {
        recentWorkoutRepo.loadWorkouts()
        let workouts = recentWorkoutRepo.workouts
        recentWorkoutAddedDelegate?.recentWorkoutDidUpdate(workouts: workouts)
    }
    
    
}
