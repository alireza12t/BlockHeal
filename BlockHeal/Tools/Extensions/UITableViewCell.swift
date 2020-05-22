//
//  UITableViewCell.swift
//  HamrameMan
//
//  Created by negar on 99/Ordibehesht/14 AP.
//  Copyright © 1399 negar. All rights reserved.
//

import UIKit

extension UITableViewCell {

    static func register(for tableView: UITableView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName + "Identifier"
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
}
