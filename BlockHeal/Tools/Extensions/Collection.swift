//
//  Collection.swift
//  HamrameMan
//
//  Created by negar on 99/Ordibehesht/16 AP.
//  Copyright © 1399 negar. All rights reserved.
//

import Foundation
extension Collection {
    public func chunk(n: Int) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}
