//
//  ClosurePropertyViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by 山本響 on 2022/07/18.
//

@testable import HardDependencies
import XCTest

class ClosurePropertyViewControllerTests: XCTestCase {
    
    func test_viewDidAppear() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: ClosurePropertyViewController = storyboard.instantiateViewController(identifier: String(describing: ClosurePropertyViewController.self))
        sut.loadViewIfNeeded()
        
        sut.makeAnalytics = { Analytics()}
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
        /**
         Test Suite 'ClosurePropertyViewControllerTests' started at 2022-07-18 11:44:58.393
         Test Case '-[HardDependenciesTests.ClosurePropertyViewControllerTests test_viewDidAppear]' started.
         >>viewDidAppear - ClosurePropertyViewController
         >>...Not the Analytics singleton
         Test Case '-[HardDependenciesTests.ClosurePropertyViewControllerTests test_viewDidAppear]' passed (0.007 seconds).
         Test Suite 'ClosurePropertyViewControllerTests' passed at 2022-07-18 11:44:58.402.
              Executed 1 test, with 0 failures (0 unexpected) in 0.007 (0.008) seconds
         */
    }

}
