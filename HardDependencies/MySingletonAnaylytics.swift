//
//  MySingletonAnaylytics.swift
//  HardDependencies
//
//  Created by 山本響 on 2022/07/17.
//

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
