//
//  ClosureViewController.swift
//  HardDependencies
//
//  Created by 山本響 on 2022/07/17.
//

import UIKit

class ClosurePropertyViewController: UIViewController {
    
    var makeAnalytics: () -> Analytics = { Analytics.shared}

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        makeAnalytics().track(event: "viewDidAppear - \(type(of: self))")
    }
    
}
