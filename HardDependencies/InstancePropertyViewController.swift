//
//  InstancePropertyViewController.swift
//  HardDependencies
//
//  Created by 山本響 on 2022/07/17.
//

import UIKit

class InstancePropertyViewController: UIViewController {
    
    lazy var analytic = Analytics.shared

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Analytics.shared.track(event: "viewDidAppear - \(type(of: self))")
        analytic.track(event: "viewDidAppear - \(type(of: self))")
        
    }
    
}
