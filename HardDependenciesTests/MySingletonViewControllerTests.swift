//
//  MySingletonViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by 山本響 on 2022/07/17.
//

@testable import HardDependencies
import XCTest

class MySingletonViewControllerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        MySingletonAnalytics.stubbedInstance = MySingletonAnalytics()
    }
    
    override class func tearDown() {
        MySingletonAnalytics.stubbedInstance = nil
        super.tearDown()
    }
    
    func test_viewDidAppear() {
        let sut = MySingletonViewController()
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
        /**
         Test Case '-[HardDependenciesTests.MySingletonViewControllerTests test_viewDidAppear]' started.
         >>viewDidAppear - MySingletonViewController
         >>...Not the MySingletonAnalytics singleton
         Test Case '-[HardDependenciesTests.MySingletonViewControllerTests test_viewDidAppear]' passed (0.042 seconds).
         */
        
    }
}
