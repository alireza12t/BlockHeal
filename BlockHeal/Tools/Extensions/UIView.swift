//
//  UIView.swift
//  HamrameMan
//
//  Created by negar on 99/Farvardin/31 AP.
//  Copyright © 1399 negar. All rights reserved.
//

import UIKit

extension UIView {
  func round(corners: CACornerMask, radius: CGFloat) {
      layer.cornerRadius = radius
      layer.maskedCorners = corners
  }
    func dropNormalShadow() {
        Log.i()

        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -3, height: 3)
        layer.shadowRadius = 5
    }
    

    func makeRound() {
        Log.i()

        layer.cornerRadius = layer.frame.height / 2
        layer.masksToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }

    func addTopBorder(borderColor: UIColor, borderHeight: CGFloat) {
        let border = CALayer()
        border.backgroundColor = borderColor.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: borderHeight)
        self.layer.addSublayer(border)
    }

    func constrainCentered(_ subview: UIView) {

      subview.translatesAutoresizingMaskIntoConstraints = false

      let verticalContraint = NSLayoutConstraint(
        item: subview,
        attribute: .centerY,
        relatedBy: .equal,
        toItem: self,
        attribute: .centerY,
        multiplier: 1.0,
        constant: 0)

      let horizontalContraint = NSLayoutConstraint(
        item: subview,
        attribute: .centerX,
        relatedBy: .equal,
        toItem: self,
        attribute: .centerX,
        multiplier: 1.0,
        constant: 0)

      let heightContraint = NSLayoutConstraint(
        item: subview,
        attribute: .height,
        relatedBy: .equal,
        toItem: nil,
        attribute: .notAnAttribute,
        multiplier: 1.0,
        constant: subview.frame.height)

      let widthContraint = NSLayoutConstraint(
        item: subview,
        attribute: .width,
        relatedBy: .equal,
        toItem: nil,
        attribute: .notAnAttribute,
        multiplier: 1.0,
        constant: subview.frame.width)

      addConstraints([
        horizontalContraint,
        verticalContraint,
        heightContraint,
        widthContraint])

    }


    func constrainToEdges(_ subview: UIView) {

      subview.translatesAutoresizingMaskIntoConstraints = false

      let topContraint = NSLayoutConstraint(
        item: subview,
        attribute: .top,
        relatedBy: .equal,
        toItem: self,
        attribute: .top,
        multiplier: 1.0,
        constant: 0)

      let bottomConstraint = NSLayoutConstraint(
        item: subview,
        attribute: .bottom,
        relatedBy: .equal,
        toItem: self,
        attribute: .bottom,
        multiplier: 1.0,
        constant: 0)

      let leadingContraint = NSLayoutConstraint(
        item: subview,
        attribute: .leading,
        relatedBy: .equal,
        toItem: self,
        attribute: .leading,
        multiplier: 1.0,
        constant: 0)

      let trailingContraint = NSLayoutConstraint(
        item: subview,
        attribute: .trailing,
        relatedBy: .equal,
        toItem: self,
        attribute: .trailing,
        multiplier: 1.0,
        constant: 0)

      addConstraints([
        topContraint,
        bottomConstraint,
        leadingContraint,
        trailingContraint])
    }

}

extension UIView {
    class func loadFromNib<T>(withName nibName: String) -> T? {
        let nib  = UINib.init(nibName: nibName, bundle: nil)
        let nibObjects = nib.instantiate(withOwner: nil, options: nil)
        for object in nibObjects {
            if let result = object as? T {
                return result
            }
        }
        return nil
    }
}
