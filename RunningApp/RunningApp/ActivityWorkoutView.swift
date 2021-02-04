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
    var body: some View {
        VStack{
            Text("Distance:  \(self.distance)").font(.largeTitle).padding()
            Text("Time").font(.largeTitle).padding()
            Button(action: {
                activityWorkoutVM.startWorkout()
            }, label: {
                Text("Start Workout")
            }).font(.largeTitle).padding().foregroundColor(.green)
        }
    }
}

struct ActivityWorkoutView_Previews: PreviewProvider {
    
    static let activityWorkoutRepo = ActivityWorkoutRepository()
    static let activityWorkoutService = ActivityWorkoutService(activityWorkoutRepo: activityWorkoutRepo)
    static var activityWorkoutVM = ActivityWorkoutViewModel(activityWorkoutService: activityWorkoutService)
    static var previews: some View {
        ActivityWorkoutView(activityWorkoutVM: activityWorkoutVM)
    }
}
