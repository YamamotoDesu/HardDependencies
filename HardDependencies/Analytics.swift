//
//  Analytics.swift
//  HardDependencies
//
//  Created by 山本響 on 2022/07/17.
//

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
