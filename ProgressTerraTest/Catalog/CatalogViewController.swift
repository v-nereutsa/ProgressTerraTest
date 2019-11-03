//
//  ViewController.swift
//  ProgressTerraTest
//
//  Created by Владимир Нереуца on 31.10.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

import UIKit

protocol CatalogControllerDelegateProtocol: AnyObject {
  
  var text: String { get set }
  
  func loadData()
  
}

final class CatalogViewController: UIViewController {
  
  @IBOutlet private weak var searchContainer: SearchContainer!
  
  private weak var delegate: CatalogControllerDelegateProtocol?
  
}

// MARK: - Life cycle
extension CatalogViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    hideSearchKeyboardWhenTapped()
  }
  
}

extension CatalogViewController {
  
  private func hideSearchKeyboardWhenTapped() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc
  private func hideKeyboard() {
    view.endEditing(true)
  }
  
}
