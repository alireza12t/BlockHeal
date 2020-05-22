//
//  UIImage.swift
//  HamrameMan
//
//  Created by tannaz on 5/16/20.
//  Copyright © 2020 negar. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  static func localImage(_ name: String, template: Bool = false) -> UIImage {
    var image = UIImage(named: name)!
    if template {
      image = image.withRenderingMode(.alwaysTemplate)
    }
    return image
  }
}
