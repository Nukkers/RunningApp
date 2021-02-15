//
//  RecentWorkoutRepositoryTests.swift
//  RunningAppTests
//
//  Created by Naukhez Ali on 12/02/2021.
//

import XCTest
@testable import RunningApp
class RecentWorkoutRepositoryTests: XCTestCase {
    
    var stubWorkoutManager: StubWorkoutManager!
    var recentWorkoutRepository: RecentWorkoutRepository!
    override func setUp() {
        stubWorkoutManager = StubWorkoutManager()
        recentWorkoutRepository = RecentWorkoutRepository()
    }
    
    func testWorkoutManagerReturnsNilWhenNoWorkoutsInStore() {
        stubWorkoutManager.stubbedLoadResult = []
        
        let expectedWorkoutInStore: [Workout] = []
        
        let actualWorkoutsInStore = recentWorkoutRepository.workouts
        
        XCTAssertEqual(expectedWorkoutInStore.count, actualWorkoutsInStore.count)
    }
}
