//
//  ActivityWorkoutRepositoryTests.swift
//  RunningAppTests
//
//  Created by Naukhez Ali on 12/02/2021.
//

import XCTest
import CoreLocation
@testable import RunningApp

class ActivityWorkoutRepositoryTests: XCTestCase {

    var stubLocationManagerProtocol: StubLocationManagerProtocol!
    var stubLocationAdapter: StubLocationManagerAdapter!
    var activityWorkoutRepo: ActivityWorkoutRepository!
    
    override func setUp() {
        stubLocationManagerProtocol = StubLocationManagerProtocol()
        stubLocationAdapter = StubLocationManagerAdapter()
        activityWorkoutRepo = ActivityWorkoutRepository(locationManager: stubLocationManagerProtocol)
    }
    
    func testRepoStartsUpdatingLocationOnStartWorkout() {
        activityWorkoutRepo.startWorkout()
        XCTAssertTrue(stubLocationManagerProtocol.invokedStartUpdatingLocation)
    }
    
    func testRepoStopsUpdatingLocationOnStopWorkout() {
        activityWorkoutRepo.stopWorkout()
        XCTAssertTrue(stubLocationManagerProtocol.invokedStopUpdatingLocation)
    }

}

class StubLocationManagerProtocol: LocationManagerProtocol {

    var invokedDistanceGetter = false
    var invokedDistanceGetterCount = 0
    var stubbedDistance: Measurement<UnitLength>!

    var distance: Measurement<UnitLength> {
        invokedDistanceGetter = true
        invokedDistanceGetterCount += 1
        return stubbedDistance
    }

    var invokedLocationListGetter = false
    var invokedLocationListGetterCount = 0
    var stubbedLocationList: [CLLocation]! = []

    var locationList: [CLLocation] {
        invokedLocationListGetter = true
        invokedLocationListGetterCount += 1
        return stubbedLocationList
    }

    var invokedLocationGetter = false
    var invokedLocationGetterCount = 0
    var stubbedLocation: CLLocation!

    var location: CLLocation? {
        invokedLocationGetter = true
        invokedLocationGetterCount += 1
        return stubbedLocation
    }

    var invokedPlacemarkGetter = false
    var invokedPlacemarkGetterCount = 0
    var stubbedPlacemark: CLPlacemark!

    var placemark: CLPlacemark? {
        invokedPlacemarkGetter = true
        invokedPlacemarkGetterCount += 1
        return stubbedPlacemark
    }

    var invokedLocationManagerGetter = false
    var invokedLocationManagerGetterCount = 0
    var stubbedLocationManager: CLLocationManager!

    var locationManager: CLLocationManager {
        invokedLocationManagerGetter = true
        invokedLocationManagerGetterCount += 1
        return stubbedLocationManager
    }

    var invokedStartUpdatingLocation = false
    var invokedStartUpdatingLocationCount = 0

    func startUpdatingLocation() {
        invokedStartUpdatingLocation = true
        invokedStartUpdatingLocationCount += 1
    }

    var invokedStopUpdatingLocation = false
    var invokedStopUpdatingLocationCount = 0

    func stopUpdatingLocation() {
        invokedStopUpdatingLocation = true
        invokedStopUpdatingLocationCount += 1
    }

    var invokedGeocode = false
    var invokedGeocodeCount = 0

    func geocode() {
        invokedGeocode = true
        invokedGeocodeCount += 1
    }
}

class StubLocationManagerAdapter: LocationManagerAdapter {

    var invokedWorkoutLocationSetter = false
    var invokedWorkoutLocationSetterCount = 0
    var invokedWorkoutLocation: [WorkoutLocation]?
    var invokedWorkoutLocationList = [[WorkoutLocation]]()
    var invokedWorkoutLocationGetter = false
    var invokedWorkoutLocationGetterCount = 0
    var stubbedWorkoutLocation: [WorkoutLocation]! = []

    var workoutLocation: [WorkoutLocation] {
        set {
            invokedWorkoutLocationSetter = true
            invokedWorkoutLocationSetterCount += 1
            invokedWorkoutLocation = newValue
            invokedWorkoutLocationList.append(newValue)
        }
        get {
            invokedWorkoutLocationGetter = true
            invokedWorkoutLocationGetterCount += 1
            return stubbedWorkoutLocation
        }
    }

    var invokedConvertPlacemark = false
    var invokedConvertPlacemarkCount = 0
    var invokedConvertPlacemarkParameters: (place: CLPlacemark, Void)?
    var invokedConvertPlacemarkParametersList = [(place: CLPlacemark, Void)]()
    var stubbedConvertPlacemarkResult: String! = ""

    override func convertPlacemark(place: CLPlacemark) -> String {
        invokedConvertPlacemark = true
        invokedConvertPlacemarkCount += 1
        invokedConvertPlacemarkParameters = (place, ())
        invokedConvertPlacemarkParametersList.append((place, ()))
        return stubbedConvertPlacemarkResult
    }

    var invokedConvertCLLocationToWorkoutLocation = false
    var invokedConvertCLLocationToWorkoutLocationCount = 0
    var invokedConvertCLLocationToWorkoutLocationParameters: (cllocations: [CLLocation], Void)?
    var invokedConvertCLLocationToWorkoutLocationParametersList = [(cllocations: [CLLocation], Void)]()
    var stubbedConvertCLLocationToWorkoutLocationResult: [WorkoutLocation]! = []

    override func convertCLLocationToWorkoutLocation(cllocations: [CLLocation]) -> [WorkoutLocation] {
        invokedConvertCLLocationToWorkoutLocation = true
        invokedConvertCLLocationToWorkoutLocationCount += 1
        invokedConvertCLLocationToWorkoutLocationParameters = (cllocations, ())
        invokedConvertCLLocationToWorkoutLocationParametersList.append((cllocations, ()))
        return stubbedConvertCLLocationToWorkoutLocationResult
    }

    var invokedConvertLocationToWorkoutLocation = false
    var invokedConvertLocationToWorkoutLocationCount = 0
    var invokedConvertLocationToWorkoutLocationParameters: (location: CLLocation, Void)?
    var invokedConvertLocationToWorkoutLocationParametersList = [(location: CLLocation, Void)]()
    var stubbedConvertLocationToWorkoutLocationResult: WorkoutLocation!

    override func convertLocationToWorkoutLocation(location: CLLocation) -> WorkoutLocation {
        invokedConvertLocationToWorkoutLocation = true
        invokedConvertLocationToWorkoutLocationCount += 1
        invokedConvertLocationToWorkoutLocationParameters = (location, ())
        invokedConvertLocationToWorkoutLocationParametersList.append((location, ()))
        return stubbedConvertLocationToWorkoutLocationResult
    }
}
