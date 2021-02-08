//
//  ActivityWorkoutService.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import Foundation

protocol WorkoutUpdatedDelegate: class {
    func workoutDidUpdate(workout: Workout)
}

class ActivityWorkoutService {
    
    private var activityWorkoutRepo: ActivityWorkoutRepository
    
    private var timer: Timer?
    
    private var workout: Workout?
    weak var workoutUpdatedDelegate: WorkoutUpdatedDelegate?
    
    init(activityWorkoutRepo: ActivityWorkoutRepository) {
        self.activityWorkoutRepo = activityWorkoutRepo
    }
    
    func startWorkout(){
        activityWorkoutRepo.startWorkout()
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.updateWorkout()
        }
        workout = Workout(distance: Measurement(value: 0, unit: UnitLength.meters), startTime: Date())
    }
    
    func stopWorkout(){
        activityWorkoutRepo.stopWorkout()
        timer?.invalidate()
        timer = nil
    }
    func pauseWorkout(){
        print("Workout Paused")
    }
    
    
    private func updateWorkout() {
        guard let workout = workout else { return }
        workout.distance = activityWorkoutRepo.distance
        workoutUpdatedDelegate?.workoutDidUpdate(workout: workout)
    }
}
