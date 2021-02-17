//
//  MapView.swift
//  RunningApp
//
//  Created by Naukhez Ali on 17/02/2021.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    @Binding var workout: Workout
    let mapView = MKMapView()
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init (_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            guard let polyline = overlay as? MKPolyline else {
                return MKOverlayRenderer(overlay: overlay)
            }
            
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .blue
            renderer.lineWidth = 3
            return renderer
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
        
        private func mapRegion(workout: Workout?) -> MKCoordinateRegion? {
            guard let locations = workout?.locationCoord, locations.count > 0
            else { return nil }
            
            let latitudes = locations.map { location -> Double in
                return location.latitude
            }
            
            let longitudes = locations.map { location -> Double in
                return location.longitude
            }
            
            let maxLat = latitudes.max()!
            let minLat = latitudes.min()!
            let maxLong = longitudes.max()!
            let minLong = longitudes.min()!
            
            let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLong + maxLong) / 2)
            let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.3, longitudeDelta: (maxLong - minLong) * 1.3)
            return MKCoordinateRegion(center: center, span: span)
            
        }
        
        private func polyline(workout: Workout?) -> MKPolyline {
            
            guard let locations = workout?.locationCoord else {
                return MKPolyline()
            }
            
            let coords: [CLLocationCoordinate2D] = locations.map { location in
                return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            }
            
            return MKPolyline(coordinates: coords, count: coords.count)
        }
        
        func loadMap(workout: Workout?, mapView: MKMapView) {
            guard let locations = workout?.locationCoord, locations.count > 0, let region = mapRegion(workout: workout) else {
                print("Locations returned empty inside loadMap function")
                return
            }
            mapView.setRegion(region, animated: true)
            mapView.addOverlay(polyline(workout: workout))
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        
        mapView.delegate = context.coordinator
        
        let annotationStart = MKPointAnnotation()
        annotationStart.title = "Start Point"
        annotationStart.subtitle = "Workout started here"
        
        let latitudes = workout.locationCoord.map { location -> Double in
            return location.latitude
        }
        
        let longitudes = workout.locationCoord.map { location -> Double in
            return location.longitude
        }
        
        let maxLat = latitudes.max()!
        let minLat = latitudes.min()!
        let maxLong = longitudes.max()!
        let minLong = longitudes.min()!
        
        // maxLat - minLong gives the start point of run
        annotationStart.coordinate = CLLocationCoordinate2D(latitude: maxLat, longitude: minLong)
        mapView.addAnnotation(annotationStart)
        
        let annotationEnd = MKPointAnnotation()
        annotationEnd.title = "End Point"
        annotationEnd.subtitle = "Workout ended here"
        
        // minLat - maxLong gives end point of run
        annotationEnd.coordinate = CLLocationCoordinate2D(latitude: minLat, longitude: maxLong)
        mapView.addAnnotation(annotationEnd)
        
        context.coordinator.loadMap(workout: self.workout, mapView: self.mapView)
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
    }
    
}
