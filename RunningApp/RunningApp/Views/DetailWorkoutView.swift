//
//  DetailWorkoutView.swift
//  RunningApp
//
//  Created by Naukhez Ali on 15/02/2021.
//

import SwiftUI

struct DetailWorkoutView: View {
    
    @State var workout: Workout
    var detailWorkoutVM: DetailWorkoutViewModel
    
    var body: some View {
        VStack{
            MapView(workout: self.$workout).edgesIgnoringSafeArea(.top)
            Spacer()
            
            Form {
                HStack (alignment: .center){
                    Text("Placemark").font(.subheadline)
                    Spacer()
                    Text("  \(detailWorkoutVM.formatPlacemark(workout: workout))").font(.title2)
                }
                
                HStack (alignment: .center) {
                    Text("Workout Duration").font(.subheadline)
                    Spacer()
                    Text(" \(detailWorkoutVM.formatWorkoutDuration(workout: self.workout))").font(.title2)
                }
                
                HStack(alignment: .center){
                    Text("Avg Speed").font(.subheadline)
                    Spacer()
                    Text(" \(detailWorkoutVM.avgPace(workout: workout))").font(.title2)
                }
                
                HStack(alignment: .center){
                    Text("Distance Covered").font(.subheadline)
                    Spacer()
                    Text(" \(detailWorkoutVM.totalDistanceCovered(workout: workout))").font(.title2)
                }
                
                HStack(alignment: .center){
                    Text("Date of Workout").font(.subheadline)
                    Spacer()
                    Text(" \(detailWorkoutVM.dateOfWorkout(workout: workout))").font(.title2)
                }
                
            }
        }
    }
}

struct DetailWorkoutView_Previews: PreviewProvider {
    static let exampleWorkout = Workout(distance: Measurement(value: 0, unit: UnitLength.meters), startTime: Date(), endTime: Date(), locationCoords: [], placemark: "", location: WorkoutLocation(lat: 0, long: 0))
    static let detailWorkoutVM = DetailWorkoutViewModel(workout: exampleWorkout)
    static var previews: some View {
        DetailWorkoutView(workout: exampleWorkout, detailWorkoutVM: detailWorkoutVM)
    }
}


