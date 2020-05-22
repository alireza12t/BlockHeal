//
//  Date.swift
//  HamrameMan
//
//  Created by ali on 4/24/20.
//  Copyright © 2020 negar. All rights reserved.
//

import Foundation

extension Date {
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
}
