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
    
    private let timer: TimerWrapperProtocol
        
    private var workout = Workout(distance: Measurement(value: 0, unit: UnitLength.meters), startTime: Date(), endTime: Date(), locationCoords: [], placemark: "", location: WorkoutLocation(lat: 0, long: 0))
    
    private var workoutManager: WorkoutManager
    
    weak var workoutUpdatedDelegate: WorkoutUpdatedDelegate?
    
    init(activityWorkoutRepo: ActivityWorkoutRepository, timerWrapper: TimerWrapperProtocol, workoutManager: WorkoutManager) {
        self.activityWorkoutRepo = activityWorkoutRepo
        self.workoutManager = workoutManager
        timer = timerWrapper
    }
    
    func startWorkout(){
        workout = Workout(distance: Measurement(value: 0, unit: UnitLength.meters), startTime: Date(), endTime: Date(), locationCoords: [], placemark: "", location: WorkoutLocation(lat: 0, long: 0))
        activityWorkoutRepo.startWorkout()
        timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            self.updateWorkout()
        }
        
    }
    
    func stopWorkout(){
        activityWorkoutRepo.stopWorkout()
        
        let endTime = Date()
        workout.endTime = endTime
        
        timer.endTimer()
        
        workoutManager.add(workout)
    }
    
    func pauseWorkout(){
        print("Workout Paused")
    }
    
    private func updateWorkout() {
        workout.distance = activityWorkoutRepo.distance
        workout.locationCoord = activityWorkoutRepo.locationCoord
        workout.location = activityWorkoutRepo.location
        workout.placemark = activityWorkoutRepo.placemark?.description
        
        workoutUpdatedDelegate?.workoutDidUpdate(workout: workout)
    }
}
