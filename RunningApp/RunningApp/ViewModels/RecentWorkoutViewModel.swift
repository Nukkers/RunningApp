//
//  RecentWorkoutViewModel.swift
//  RunningApp
//
//  Created by Naukhez Ali on 10/02/2021.
//

import Foundation

class RecentWorkoutViewModel: ObservableObject {
    
    private let recentWorkoutService: RecentWorkoutService
    @Published var workouts: [Workout] = []
    
    init(recentWorkoutService: RecentWorkoutService) {
        self.recentWorkoutService = recentWorkoutService
        recentWorkoutService.recentWorkoutAddedDelegate = self
    }
    
    func getAllRecentWorkouts() {
        recentWorkoutService.getRecentWorkouts()
    }
    
    func formatDistance(workout: Workout) -> String {
        return FormatDisplay.distance(workout.distance)
    }
    
    func formatWorkoutDuration(workout: Workout) -> String {
        return FormatDisplay.WorkoutDuration(workout: workout)
    }
    
    func formatPlacemark(workout: Workout) -> String {
        return FormatDisplay.placemark(workout: workout)
    }
    
}

extension RecentWorkoutViewModel: RecentWorkoutAddedDelegate {
    func recentWorkoutDidUpdate(workouts: [Workout]) {
        self.workouts = workouts
    }
    
}
