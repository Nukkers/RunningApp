//
//  ActivityServiceTests.swift
//  RunningAppTests
//
//  Created by Naukhez Ali on 12/02/2021.
//

import XCTest
@testable import RunningApp

class ActivityWorkoutServiceTests: XCTestCase {

    var stubTimerWrapper: StubTimerWrapper!
    var stubActivityWorkoutRepo: StubActivityWorkoutRepository!
    var stubWorkoutUpdatedDelegate: StubWorkoutUpdatedDelegate!
    var stubWorkoutManager: StubWorkoutManager!
    var stubLocationManagerProtocol: StubLocationManagerProtocol!
    var activityService: ActivityWorkoutService!
    
    override func setUp() {
        stubLocationManagerProtocol = StubLocationManagerProtocol()
        stubActivityWorkoutRepo = StubActivityWorkoutRepository(locationManager: stubLocationManagerProtocol)
        stubTimerWrapper = StubTimerWrapper()
        stubWorkoutUpdatedDelegate = StubWorkoutUpdatedDelegate()
        stubWorkoutManager = StubWorkoutManager()
        activityService = ActivityWorkoutService(activityWorkoutRepo: stubActivityWorkoutRepo, timerWrapper: stubTimerWrapper, workoutManager: stubWorkoutManager)
        activityService.workoutUpdatedDelegate = stubWorkoutUpdatedDelegate
    }
    
    func testWorkoutRepoStartedWhenWorkoutStarted() {
        activityService.startWorkout()
        XCTAssertTrue(stubActivityWorkoutRepo.invokedStartWorkout)
    }
    
    func testTimerIsScheduledWhenCallStartWorkout() {
        activityService.startWorkout()
        XCTAssertTrue(stubTimerWrapper.invokedScheduledTimer)
        XCTAssertEqual(stubTimerWrapper.invokedScheduledTimerParameters?.interval, 1.0)
    }
    
    func testANewWorkoutIsCreatedOnStartWorkout() {
        
        stubTimerWrapper.shouldInvokeScheduledTimerBlock = true
        stubActivityWorkoutRepo.stubbedDistance = Measurement(value: 0, unit: UnitLength.meters)
        activityService.startWorkout()
        
        XCTAssertTrue(stubWorkoutUpdatedDelegate.invokedWorkoutDidUpdate)
        XCTAssertEqual(stubWorkoutUpdatedDelegate.invokedWorkoutDidUpdateCount, 1)
        XCTAssertEqual(stubWorkoutUpdatedDelegate.invokedWorkoutDidUpdateParameters?.workout.distance, Measurement(value: 0, unit: UnitLength.meters))
    }
    
    func testWorkoutDistanceIsTakenFromRepo() {
        
        let expectedDistance = 0.5
        stubTimerWrapper.shouldInvokeScheduledTimerBlock = true
        stubActivityWorkoutRepo.stubbedDistance = Measurement(value: expectedDistance, unit: UnitLength.meters)
        activityService.startWorkout()
        
        XCTAssertEqual(stubWorkoutUpdatedDelegate.invokedWorkoutDidUpdateParameters?.workout.distance, Measurement(value: expectedDistance, unit: UnitLength.meters))
    }

    func testWorkoutRepoStoppedWhenWorkoutStopped() {
        activityService.stopWorkout()
        XCTAssertTrue(stubActivityWorkoutRepo.invokedStopWorkout)
    }
    
    func testEndTimerCalledWhenWorkoutStopped() {
        activityService.stopWorkout()
        
        XCTAssertTrue(stubTimerWrapper.invokedEndTimer)
    }

    func testNewWorkoutSavedWhenWorkoutStopped() {
        
        activityService.stopWorkout()
        
        XCTAssertTrue(stubWorkoutManager.invokedAdd)
        XCTAssertEqual(stubWorkoutManager.invokedAddCount, 1)
        
    }

}

class StubTimerWrapper: TimerWrapper {

    var invokedHasTimerGetter = false
    var invokedHasTimerGetterCount = 0
    var stubbedHasTimer: Bool! = false

    override var hasTimer: Bool {
        invokedHasTimerGetter = true
        invokedHasTimerGetterCount += 1
        return stubbedHasTimer
    }

    var invokedFireDateGetter = false
    var invokedFireDateGetterCount = 0
    var stubbedFireDate: Date!

    override var fireDate: Date? {
        invokedFireDateGetter = true
        invokedFireDateGetterCount += 1
        return stubbedFireDate
    }

    var invokedScheduledTimer = false
    var invokedScheduledTimerCount = 0
    var invokedScheduledTimerParameters: (interval: TimeInterval, repeats: Bool)?
    var invokedScheduledTimerParametersList = [(interval: TimeInterval, repeats: Bool)]()
    var shouldInvokeScheduledTimerBlock = false

    override func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping () -> Swift.Void) {
        invokedScheduledTimer = true
        invokedScheduledTimerCount += 1
        invokedScheduledTimerParameters = (interval, repeats)
        invokedScheduledTimerParametersList.append((interval, repeats))
        if shouldInvokeScheduledTimerBlock {
            _ = block()
        }
    }

    var invokedEndTimer = false
    var invokedEndTimerCount = 0

    override func endTimer() {
        invokedEndTimer = true
        invokedEndTimerCount += 1
    }
}

class StubWorkoutManager: UserDefaultsWorkoutStorageRepo {

    var invokedWorkoutsSetter = false
    var invokedWorkoutsSetterCount = 0
    var invokedWorkouts: [Workout]?
    var invokedWorkoutsList = [[Workout]]()
    var invokedWorkoutsGetter = false
    var invokedWorkoutsGetterCount = 0
    var stubbedWorkouts: [Workout]! = []

    override var workouts: [Workout] {
        set {
            invokedWorkoutsSetter = true
            invokedWorkoutsSetterCount += 1
            invokedWorkouts = newValue
            invokedWorkoutsList.append(newValue)
        }
        get {
            invokedWorkoutsGetter = true
            invokedWorkoutsGetterCount += 1
            return stubbedWorkouts
        }
    }

    var invokedLoad = false
    var invokedLoadCount = 0
    var stubbedLoadResult: [Workout]! = []

    override func load() -> [Workout] {
        invokedLoad = true
        invokedLoadCount += 1
        return stubbedLoadResult
    }

    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (newWorkout: Workout, Void)?
    var invokedAddParametersList = [(newWorkout: Workout, Void)]()

    override func add(_ newWorkout: Workout) {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (newWorkout, ())
        invokedAddParametersList.append((newWorkout, ()))
    }
}
