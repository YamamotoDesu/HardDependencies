# HardDependencies
iOS Unit Testing by Example - Chapter 6

![image](https://user-images.githubusercontent.com/47273077/178744829-44543765-d038-4d50-938d-7fb790badb98.png)

Analytics.swift
```swift
import Foundation

class Analytics {
    static let shared  = Analytics()
    
    func track(event: String) {
        print(">>" + event)
        
        if self !== Analytics.shared {
            print(">>...Not the Analytics singleton")
        }
    }
}
```
-----

## 
Putting a singleton backdoor on a singleton you own. Use only for legacy code, not for legacy code.
MySingletonAnaylytics.swift
```swift

import Foundation

class MySingletonAnalytics {
    
    private static let instance = MySingletonAnalytics()
    
    #if DEBUG
    static var stubbedInstance: MySingletonAnalytics?
    #endif
    
    static var shared: MySingletonAnalytics {
        #if DEBUG
        if let stubbedInstance = stubbedInstance {
            return stubbedInstance
        }
        #endif
        return instance
    }
    
    func track(event: String) {
        print(">>" + event)
        
        if self !== MySingletonAnalytics.instance {
            print(">>...Not the MySingletonAnalytics singleton")
        }
    }
    
}
```

MySingletonViewControllerTests.swift
```swift
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
```

-----

## 
Subclass and Override Method, using a test-specific subclass. 
OverriddeViewController.swift
```swift
import UIKit

class OverriddeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func analytics() -> Analytics {
        return Analytics.shared
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        analytics().track(event: "viewDidAppear - \(type(of: self))")
    }

}
```

OverrideViewControllerTests
```swift
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
```
