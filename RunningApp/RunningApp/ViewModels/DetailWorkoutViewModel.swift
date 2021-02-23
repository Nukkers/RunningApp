//
//  DetailWorkoutViewModel.swift
//  RunningApp
//
//  Created by Naukhez Ali on 18/02/2021.
//

import Foundation

class DetailWorkoutViewModel {
    var workout: Workout

    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func formatWorkoutDuration(workout: Workout) -> String {
        return FormatDisplay.WorkoutDuration(workout: workout)
    }
    
    func formatPlacemark(workout: Workout) -> String {
        return FormatDisplay.placemark(workout: workout)
    }
    
    func avgPace(workout: Workout) -> String {
        
        let duration = workout.startTime.distance(to: workout.endTime)
        
        return FormatDisplay.pace(distance: workout.distance, seconds: Int(duration), outputUnit: UnitSpeed.minutesPerMile)
    }
    
    func totalDistanceCovered(workout: Workout) -> String {
        let dis = FormatDisplay.distance(workout.distance)
        return dis.description
    }
    
    func dateOfWorkout(workout: Workout) -> String {
        return FormatDisplay.date(workout.startTime)
    }
}
