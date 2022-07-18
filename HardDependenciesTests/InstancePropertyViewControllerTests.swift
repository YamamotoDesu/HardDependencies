//
//  InstancePropertyViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by 山本響 on 2022/07/17.
//

@testable import HardDependencies
import XCTest

class InstancePropertyViewControllerTests: XCTestCase {

    func test_viewDidAppear() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut: InstancePropertyViewController = storyboard.instantiateViewController(identifier: String(describing: InstancePropertyViewController.self))
        sut.analytic = Analytics()
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
        /**
         Test Case '-[HardDependenciesTests.InstancePropertyViewControllerTests test_viewDidAppear]' started.
         >>viewDidAppear - InstancePropertyViewController
         >>...Not the Analytics singleton
         Test Case '-[HardDependenciesTests.InstancePropertyViewControllerTests test_viewDidAppear]' passed (0.013 seconds).
         */
        
    }

}

