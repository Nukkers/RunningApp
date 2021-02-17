//
//  ContentView.swift
//  RunningApp
//
//  Created by Naukhez Ali on 06/01/2021.
//

import SwiftUI

struct RecentWorkoutView: View {
    
    var body: some View {
        let recentWorkoutRepo = RecentWorkoutRepository()
        let recentWorkoutService = RecentWorkoutService(recentWorkoutRepo: recentWorkoutRepo)
        let recentWorkoutVm = RecentWorkoutViewModel(recentWorkoutService: recentWorkoutService)
        
        Home(recentWorkoutVm: recentWorkoutVm)
        
    }
}

struct RecentWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        RecentWorkoutView().padding(.top, 60)
    }
}

struct Home: View {
    @ObservedObject var recentWorkoutVm: RecentWorkoutViewModel
    
    var workouts: [Workout] {
        recentWorkoutVm.workouts ?? []
    }
    
    var body: some View{
        NavigationView {
            List(workouts) { workout in
                NavigationLink(destination: DetailWorkoutView(workout: workout)) {
                    let duration = workout.startTime.timeIntervalSinceNow * -1
                    Text("Distance: \(FormatDisplay.distance(workout.distance))")
                    Text("Time: \(FormatDisplay.time(Int(duration)))")
                }
            }.padding(.top, 60).onAppear(perform: recentWorkoutVm.getAllRecentWorkouts)
            .navigationBarTitle("Workouts", displayMode: .large)
        }
    }
}


