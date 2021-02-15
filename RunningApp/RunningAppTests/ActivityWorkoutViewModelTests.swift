//
//  ActivityWorkoutViewModelTests.swift
//  RunningAppTests
//
//  Created by Naukhez Ali on 12/02/2021.
//

import XCTest
@testable import RunningApp

class ActivityWorkoutViewModelTests: XCTestCase {
    
    var activityWorkoutVM: ActivityWorkoutViewModel!
    var stubActivityWorkoutService: StubActivityWorkoutService!
    var stubActivityWorkoutUpdatedDelegate: StubWorkoutUpdatedDelegate!
    var stubActivityWorkoutRepo: StubActivityWorkoutRepository!
    var stubTimerWrapper: StubTimerWrapper!
    var stubWorkoutManager: StubWorkoutManager!
    
    override func setUp() {
        stubActivityWorkoutRepo = StubActivityWorkoutRepository()
        stubTimerWrapper = StubTimerWrapper()
        stubWorkoutManager = StubWorkoutManager()
        
        stubActivityWorkoutService = StubActivityWorkoutService(activityWorkoutRepo: stubActivityWorkoutRepo, timerWrapper: stubTimerWrapper, workoutManager: stubWorkoutManager)
        
        activityWorkoutVM = ActivityWorkoutViewModel(activityWorkoutService: stubActivityWorkoutService)
        
        stubActivityWorkoutUpdatedDelegate = StubWorkoutUpdatedDelegate()
        
        stubActivityWorkoutService.workoutUpdatedDelegate = stubActivityWorkoutUpdatedDelegate
    }
    
    func testSuccessfullyCallsStartWorkoutInService() {
        activityWorkoutVM.startWorkout()
        XCTAssertTrue(stubActivityWorkoutService.invokedStartWorkout)
    }
    
    func testCallsStopWorkoutInService() {
        activityWorkoutVM.stopWorkout()
        
        XCTAssertTrue(stubActivityWorkoutService.invokedStopWorkout)
    }
    
    func testWorkoutUpdatedDelegateFormatsNewWorkoutObject() {
        let expectedDistance = Measurement(value: 0, unit: UnitLength.meters)
        let expectedWorkout = Workout(distance: expectedDistance, startTime: Date())
        
        let formattedDistance = FormatDisplay.distance(expectedDistance)
        
        activityWorkoutVM.workoutDidUpdate(workout: expectedWorkout)
        
        
        XCTAssertEqual(activityWorkoutVM.distance, formattedDistance)
    }
    
}

class StubActivityWorkoutRepository: ActivityWorkoutRepository {

    var invokedDistanceGetter = false
    var invokedDistanceGetterCount = 0
    var stubbedDistance: Measurement<UnitLength>!

    override var distance: Measurement<UnitLength> {
        invokedDistanceGetter = true
        invokedDistanceGetterCount += 1
        return stubbedDistance
    }

    var invokedStartWorkout = false
    var invokedStartWorkoutCount = 0

    override func startWorkout() {
        invokedStartWorkout = true
        invokedStartWorkoutCount += 1
    }

    var invokedStopWorkout = false
    var invokedStopWorkoutCount = 0

    override func stopWorkout() {
        invokedStopWorkout = true
        invokedStopWorkoutCount += 1
    }
}

class StubWorkoutUpdatedDelegate: WorkoutUpdatedDelegate {

    var invokedWorkoutDidUpdate = false
    var invokedWorkoutDidUpdateCount = 0
    var invokedWorkoutDidUpdateParameters: (workout: Workout, Void)?
    var invokedWorkoutDidUpdateParametersList = [(workout: Workout, Void)]()

    func workoutDidUpdate(workout: Workout) {
        invokedWorkoutDidUpdate = true
        invokedWorkoutDidUpdateCount += 1
        invokedWorkoutDidUpdateParameters = (workout, ())
        invokedWorkoutDidUpdateParametersList.append((workout, ()))
    }
}

class StubActivityWorkoutService: ActivityWorkoutService {

    var invokedWorkoutUpdatedDelegateSetter = false
    var invokedWorkoutUpdatedDelegateSetterCount = 0
    var invokedWorkoutUpdatedDelegate: WorkoutUpdatedDelegate?
    var invokedWorkoutUpdatedDelegateList = [WorkoutUpdatedDelegate?]()
    var invokedWorkoutUpdatedDelegateGetter = false
    var invokedWorkoutUpdatedDelegateGetterCount = 0
    var stubbedWorkoutUpdatedDelegate: WorkoutUpdatedDelegate!

    override var workoutUpdatedDelegate: WorkoutUpdatedDelegate? {
        set {
            invokedWorkoutUpdatedDelegateSetter = true
            invokedWorkoutUpdatedDelegateSetterCount += 1
            invokedWorkoutUpdatedDelegate = newValue
            invokedWorkoutUpdatedDelegateList.append(newValue)
        }
        get {
            invokedWorkoutUpdatedDelegateGetter = true
            invokedWorkoutUpdatedDelegateGetterCount += 1
            return stubbedWorkoutUpdatedDelegate
        }
    }

    var invokedStartWorkout = false
    var invokedStartWorkoutCount = 0

    override func startWorkout() {
        invokedStartWorkout = true
        invokedStartWorkoutCount += 1
    }

    var invokedStopWorkout = false
    var invokedStopWorkoutCount = 0

    override func stopWorkout() {
        invokedStopWorkout = true
        invokedStopWorkoutCount += 1
    }

    var invokedPauseWorkout = false
    var invokedPauseWorkoutCount = 0

    override func pauseWorkout() {
        invokedPauseWorkout = true
        invokedPauseWorkoutCount += 1
    }
}
