//
//  UIViewController+DismissKeyboard.swift
//  ProgressTerraTest
//
//  Created by Владислав Игнатьев on 03.11.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

import UIKit

extension UIViewController {
  
  @objc
  func dismissKeyboard() {
    view.endEditing(true)
  }
  
}
