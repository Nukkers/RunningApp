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
      
        let workout = Workout(distance: Measurement(value: 0, unit: UnitLength.meters), startTime: Date(), endTime: Date(), locationCoords: [], placemark: "", location: WorkoutLocation(lat: 0, long: 0))

        let detailWorkoutVM = DetailWorkoutViewModel(workout: workout)
        Home(recentWorkoutVm: recentWorkoutVm, detailWorkoutVm: detailWorkoutVM)
        
    }
}

struct RecentWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        RecentWorkoutView().padding(.top, 60)
    }
}

struct Home: View {
    @ObservedObject var recentWorkoutVm: RecentWorkoutViewModel
    let detailWorkoutVm: DetailWorkoutViewModel
    
    var workouts: [Workout] {
        recentWorkoutVm.workouts
    }
    
    var body: some View{
        NavigationView {
            List(workouts) { workout in
                NavigationLink(destination: DetailWorkoutView(workout: workout, detailWorkoutVM: detailWorkoutVm)) {
                    WorkoutList(recentWorkoutVm: recentWorkoutVm, workout: workout)
                }
            }.padding(.top, 60).onAppear(perform: recentWorkoutVm.getAllRecentWorkouts)
            .navigationBarTitle("Workouts", displayMode: .large)
        }
    }
}


struct WorkoutList: View {
    
    var recentWorkoutVm: RecentWorkoutViewModel
    var workout: Workout
    
    var body: some View {
        HStack{
            VStack (alignment: .leading){
                Text("Distance").font(.footnote)
                Text("\(recentWorkoutVm.formatDistance(workout: workout))").font(.title2)
                
            }
            Divider()
            VStack (alignment: .leading){
                Text("Duration").font(.footnote)
                Text("\(recentWorkoutVm.formatWorkoutDuration(workout: workout))").font(.title2)
            }
            Spacer()
            Divider()
            VStack (alignment: .leading){
                Text("Placemark").font(.footnote)
                Text("\(recentWorkoutVm.formatPlacemark(workout: workout))").font(.title2)
            }
        }
    }
}

