//
//  PatientUIViewController.swift
//  BlockHeal
//
//  Created by ali on 6/17/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit

class PatientUIViewController: BaseViewController {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var mainViewv: UIView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mainViewv.roundCorners(corners: [.topLeft, .topRight], radius: 30)
        
    }
    
    
}
