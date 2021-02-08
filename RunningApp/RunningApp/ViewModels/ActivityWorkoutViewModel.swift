//
//  ActivityWorkoutViewModel.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import Foundation
import Combine

class ActivityWorkoutViewModel: ObservableObject {
    
    private var activityWorkoutService: ActivityWorkoutService
    @Published var distance: String?
    @Published var workoutTime: String?
    @Published var pace: String?
    
    init(activityWorkoutService: ActivityWorkoutService) {
        self.activityWorkoutService = activityWorkoutService
        activityWorkoutService.workoutUpdatedDelegate = self
    }
    
    func startWorkout() {
        self.activityWorkoutService.startWorkout()
    }
    
    func stopWorkout() {
        self.activityWorkoutService.stopWorkout()
    }
    
    func pauseWorkout() {
        self.activityWorkoutService.pauseWorkout()
    }
    
}

extension ActivityWorkoutViewModel: WorkoutUpdatedDelegate {
    func workoutDidUpdate(workout: Workout) {
        self.distance = FormatDisplay.distance(workout.distance)
        let workoutDuration = workout.startTime.timeIntervalSinceNow * -1
        
        let formattedTime = FormatDisplay.time(Int(workoutDuration))
        self.workoutTime = formattedTime
        
        let formattedPace = FormatDisplay.pace(distance: workout.distance, seconds: Int(workoutDuration), outputUnit: UnitSpeed.minutesPerMile)
        self.pace = formattedPace
        
    }
    
}
