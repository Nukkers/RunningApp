//
//  ActivityWorkoutView.swift
//  RunningApp
//
//  Created by Naukhez Ali on 03/02/2021.
//

import SwiftUI

struct ActivityWorkoutView: View {
    
    @ObservedObject var activityWorkoutVM: ActivityWorkoutViewModel
    var distance: String {
        activityWorkoutVM.distance ?? "0 mi"
    }
    var time: String {
        activityWorkoutVM.workoutTime ?? "0:00:00"
    }
    var pace: String {
        activityWorkoutVM.pace ?? "0"
    }
    
    @State private var didTapStartWorkoutBtn: Bool = false
    
    var body: some View {
        VStack{
            Text("Distance:  \(self.distance)").font(.largeTitle).padding()
            Text("Time: \(self.time)").font(.largeTitle).padding()
            Text("Pace: \(self.pace)").font(.largeTitle).padding()
            
            if(didTapStartWorkoutBtn == false) {
                Button(action: {
                    activityWorkoutVM.startWorkout()
                    self.didTapStartWorkoutBtn = true
                }, label: {
                    Text("Start Workout").foregroundColor(Color.green)
                }).font(.largeTitle).padding()
            }
            
            if(didTapStartWorkoutBtn == true) {
                Button(action: {
                    activityWorkoutVM.stopWorkout()
                    didTapStartWorkoutBtn = false
                }, label: {
                    Text("Stop Workout")
                }).font(.largeTitle).padding()
            }
        }
    }
}

struct ActivityWorkoutView_Previews: PreviewProvider {
    
    static let activityWorkoutRepo = ActivityWorkoutRepository()
    static let timerWrapper = TimerWrapper()
    static let workoutManager = WorkoutManager()
    static let activityWorkoutService = ActivityWorkoutService(activityWorkoutRepo: activityWorkoutRepo, timerWrapper: timerWrapper, workoutManager: workoutManager)
    static var activityWorkoutVM = ActivityWorkoutViewModel(activityWorkoutService: activityWorkoutService)
    static var previews: some View {
        ActivityWorkoutView(activityWorkoutVM: activityWorkoutVM)
    }
}
