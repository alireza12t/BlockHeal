//
//  SplashViewController.swift
//  BlockHeal
//
//  Created by ali on 6/19/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.viewControllers = [MainViewController.instantiateFromStoryboardName(storyboardName: .Main)]
    }

}
