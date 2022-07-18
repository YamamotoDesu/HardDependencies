//
//  InstanceInitializerViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by 山本響 on 2022/07/17.
//

@testable import HardDependencies
import XCTest

class InstanceInitializerViewControllerTests: XCTestCase {

    func test_viewDidAppear() {
        let sut = InstanceInitializerViewController(anaylytic: Analytics())
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
    }

}
