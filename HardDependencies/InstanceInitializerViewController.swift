//
//  InstanceInitializerViewController.swift
//  HardDependencies
//
//  Created by 山本響 on 2022/07/17.
//

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
