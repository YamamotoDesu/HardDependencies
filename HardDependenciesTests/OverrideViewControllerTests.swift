//
//  OverrideViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by 山本響 on 2022/07/17.
//

@testable import HardDependencies
import XCTest

class OverrideViewControllerTests: XCTestCase {

    private class TestableOverrideViewController: OverriddeViewController {
        override func analytics() -> Analytics { Analytics() }
    }
    
    func test_viewDidAppear() {
        let sut = TestableOverrideViewController()
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
        /***
         Test Case '-[HardDependenciesTests.OverrideViewControllerTests test_viewDidAppear]' started.
         >>viewDidAppear - TestableOverrideViewController
         >>...Not the Analytics singleton
         Test Case '-[HardDependenciesTests.OverrideViewControllerTests test_viewDidAppear]' passed (0.038 seconds).
         */
    }
 
}
