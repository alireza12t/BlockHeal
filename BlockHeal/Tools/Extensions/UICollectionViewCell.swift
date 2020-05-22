//
//  UICollectionViewCell.swift
//  HamrameMan
//
//  Created by negar on 99/Ordibehesht/11 AP.
//  Copyright © 1399 negar. All rights reserved.
//

import UIKit

extension UICollectionViewCell {

    static func register(for collectionView: UICollectionView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName + "Identifier"
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
