//
//  MySingletonViewController.swift
//  HardDependencies
//
//  Created by 山本響 on 2022/07/17.
//

import UIKit

class MySingletonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        MySingletonAnalytics.shared.track(event: "viewDidAppear - \(type(of: self))")
    }
    
}
