//
//  ContentView.swift
//  RunningApp
//
//  Created by Naukhez Ali on 06/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        let activityWorkoutRepo = ActivityWorkoutRepository()
        
        let activityWorkoutService = ActivityWorkoutService(activityWorkoutRepo: activityWorkoutRepo)
        let activityWorkoutVM = ActivityWorkoutViewModel(activityWorkoutService: activityWorkoutService)
        
        Home(activityWorkoutVM: activityWorkoutVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    
    var activityWorkoutVM: ActivityWorkoutViewModel
    
    var body: some View{
        NavigationView{
            VStack{
                NavigationLink(destination: ActivityWorkoutView(activityWorkoutVM: activityWorkoutVM)){
                    Text("Start Workout")
                }
            }
        }
        
    }
}


