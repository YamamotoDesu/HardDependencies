//
//  OverriddeViewController.swift
//  HardDependencies
//
//  Created by 山本響 on 2022/07/17.
//

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
