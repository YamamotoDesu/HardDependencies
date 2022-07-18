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

----

## Constructor injection 
Injecting dependencies through initializers -- constructor injection

InstanceInitializerViewController
```swift
import UIKit

class InstanceInitializerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Analytics.shared.track(event: "viewDidAppear - \(type(of: self))")
    }
    
    private let analytics: Analytics
    
    init(anaylytic: Analytics = Analytics.shared) {
        self.analytics = anaylytic
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
```

InstanceInitializerViewControllerTests
```swift
@testable import HardDependencies
import XCTest

class InstanceInitializerViewControllerTests: XCTestCase {

    func test_viewDidAppear() {
        let sut = InstanceInitializerViewController(anaylytic: Analytics())
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
        /**
         Test Suite 'InstanceInitializerViewControllerTests' started at 2022-07-18 11:44:58.403
         Test Case '-[HardDependenciesTests.InstanceInitializerViewControllerTests test_viewDidAppear]' started.
         >>viewDidAppear - InstanceInitializerViewController
         Test Case '-[HardDependenciesTests.InstanceInitializerViewControllerTests test_viewDidAppear]' passed (0.009 seconds).
         Test Suite 'InstanceInitializerViewControllerTests' passed at 2022-07-18 11:44:58.413.
              Executed 1 test, with 0 failures (0 unexpected) in 0.009 (0.010) seconds
         */
    }

}
```

## Closure Constructor injection 

ClosureIniializerViewController
```swift
import UIKit

class ClosureIniializerViewController: UIViewController {
    
    private let makeAnalytics: () -> Analytics
    
    init(makeAnalytics: @escaping () -> Analytics = { Analytics.shared }) {
        self.makeAnalytics = makeAnalytics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        makeAnalytics().track(event: "viewDidAppear - \(type(of: self))")
    }

}
```

ClosureInitializerViewControllerTests
```swift

@testable import HardDependencies
import XCTest

class ClosureInitializerViewControllerTests: XCTestCase {

    func test_viewDidAppear() {
        let sut = ClosureIniializerViewController { Analytics()}
        sut.loadViewIfNeeded()
        
        sut.viewDidAppear(false)
        /**
         Test Suite 'ClosureInitializerViewControllerTests' started at 2022-07-18 11:44:58.384
         Test Case '-[HardDependenciesTests.ClosureInitializerViewControllerTests test_viewDidAppear]' started.
         >>viewDidAppear - ClosureIniializerViewController
         >>...Not the Analytics singleton
         Test Case '-[HardDependenciesTests.ClosureInitializerViewControllerTests test_viewDidAppear]' passed (0.007 seconds).
         Test Suite 'ClosureInitializerViewControllerTests' passed at 2022-07-18 11:44:58.393.
              Executed 1 test, with 0 failures (0 unexpected) in 0.007 (0.009) seconds
         */
    }

}
```
