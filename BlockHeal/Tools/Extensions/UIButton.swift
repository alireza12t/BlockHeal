//
//  UIButton.swift
//  HamrameMan
//
//  Created by ali on 5/1/20.
//  Copyright © 2020 negar. All rights reserved.
//

import UIKit
import Spring

extension DesignableButton {
    static func makeButtonBlue(button: DesignableButton?){
        
        button?.setTitleColor(.white, for: .normal)
        button?.shadowOpacity = 0.6
        button?.shadowOffsetY = 1.5
        button?.shadowRadius = 5
        button?.backgroundColor = .brandBlue
    }
    
    static func makeButtonGray(button: DesignableButton?){
        
        button?.shadowOpacity = 0
        button?.shadowOffsetY = 0
        button?.shadowRadius = 0
        button?.backgroundColor = .gray95
        button?.setTitleColor(.black, for: .normal)
    }
    
    static func makeButtonOrange(button: DesignableButton){
        button.backgroundColor = .brandOrange
    }
    

}

