//
//  UIViewController+Alert.swift
//  ProgressTerraTest
//
//  Created by Владимир Нереуца on 03.11.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

import UIKit

extension UIViewController {
  
  func okAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
  
}
