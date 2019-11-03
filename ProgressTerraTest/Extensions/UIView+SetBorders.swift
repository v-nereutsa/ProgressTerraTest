//
//  UIView+SetBorder.swift
//  ProgressTerraTest
//
//  Created by Владимир Нереуца on 03.11.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

import UIKit

extension UIView {
  
  func setBorder(color: UIColor, width: CGFloat, cornerRadius: CGFloat) {
    layer.borderWidth = width
    layer.borderColor = color.cgColor
    layer.cornerRadius = cornerRadius
  }
  
}
