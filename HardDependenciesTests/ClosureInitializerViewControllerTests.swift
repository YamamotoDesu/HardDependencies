//
//  ClosureInitializerViewControllerTests.swift
//  HardDependenciesTests
//
//  Created by 山本響 on 2022/07/18.
//

@testable import HardDependencies
import XCTest

class ClosureInitializerViewControllerTests: XCTestCase {

    func test_viewDidAppear() {
        let sut = ClosureIniializerViewController { Analytics()}
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
    }

}
