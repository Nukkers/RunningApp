//
//  TabBarView.swift
//  RunningApp
//
//  Created by Naukhez Ali on 11/02/2021.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        let locationManager = LocationManager()
        let activityWorkoutRepo = ActivityWorkoutRepository(locationManager: locationManager)
        let timerWrapper = TimerWrapper()
        let workoutManager = UserDefaultsWorkoutStorageRepo()

        let activityWorkoutService = ActivityWorkoutService(activityWorkoutRepo: activityWorkoutRepo, timerWrapper: timerWrapper, workoutManager: workoutManager)
        
        let activityWorkoutVM = ActivityWorkoutViewModel(activityWorkoutService: activityWorkoutService)
        
        TabView {
            RecentWorkoutView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Recent Workouts")
                }
            ActivityWorkoutView(activityWorkoutVM: activityWorkoutVM)
                .tabItem {
                    Image(systemName: "smallcircle.fill.circle.fill")
                    Text("Record Workout")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
