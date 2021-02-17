//
//  DetailWorkoutView.swift
//  RunningApp
//
//  Created by Naukhez Ali on 15/02/2021.
//

import SwiftUI

struct DetailWorkoutView: View {
    
    @State var workout: Workout
    
    var body: some View {
        VStack{
            MapView(workout: self.$workout).edgesIgnoringSafeArea(.top)
            Spacer()
                
            Form {
                Section{
                    Text("Workout Name")
                    Text("Workout Duration \(workout.startTime)")
                    Text("Avg Speed \(workout.distance)")
                    Text("Calories Burnt")
                    Text("Distance Covered")
                    Text("Date of Workout")
                    Text("Max Elevation")
                }
            }
        }
    }
}

struct DetailWorkoutView_Previews: PreviewProvider {
    static let exampleWorkout = Workout(distance: Measurement(value: 0, unit: UnitLength.meters), startTime: Date(), endTime: Date(), locationCoords: [], placemark: "", location: WorkoutLocation(lat: 0, long: 0))
    static var previews: some View {
        DetailWorkoutView(workout: exampleWorkout)
    }
}


