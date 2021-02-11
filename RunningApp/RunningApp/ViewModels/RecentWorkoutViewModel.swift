//
//  RecentWorkoutViewModel.swift
//  RunningApp
//
//  Created by Naukhez Ali on 10/02/2021.
//

import Foundation

class RecentWorkoutViewModel: ObservableObject {
    
    private let recentWorkoutService: RecentWorkoutService
    @Published var workouts: [Workout]?
    
    init(recentWorkoutService: RecentWorkoutService) {
        self.recentWorkoutService = recentWorkoutService
        recentWorkoutService.recentWorkoutAddedDelegate = self
//        getAllRecentWorkouts()
    }
    
    func getAllRecentWorkouts() {
        recentWorkoutService.getRecentWorkouts()
    }
    
}

extension RecentWorkoutViewModel: RecentWorkoutAddedDelegate {
    func recentWorkoutDidUpdate(workouts: [Workout]) {
        self.workouts = workouts
    }
    
}
