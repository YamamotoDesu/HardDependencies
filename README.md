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


