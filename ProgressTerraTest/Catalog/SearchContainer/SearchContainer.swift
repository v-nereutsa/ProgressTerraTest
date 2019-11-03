//
//  SearchView.swift
//  ProgressTerraTest
//
//  Created by Владимир Нереуца on 31.10.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

import UIKit

final class SearchContainer: UIView {
  
  @IBOutlet private weak var searchContainer: SearchContainer!
  @IBOutlet private weak var borderView: UIView!
  @IBOutlet private weak var searchButtonBorder: UIView!
  @IBOutlet private weak var searchTextField: UITextField!
  @IBOutlet private weak var searchButton: UIButton!
  
  weak var delegate: SearchContainerDelegate?
  
  var state = SearchContainerStates.long {
    didSet {
      updateUI(for: state)
    }
  }
  
  @IBAction private func touchSearchButton(_ sender: UIButton) {
    searchTextField.becomeFirstResponder()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    addSearchContiner()
    setupAppearance()
    searchTextField.delegate = self
  }
  
  private func addSearchContiner() {
    Bundle.main.loadNibNamed("SearchContainer", owner: self, options: nil)
    addSubview(searchContainer)
    searchContainer.frame = self.bounds
    searchContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
  
  enum SearchContainerStates {
    case long
    case short
  }
  
}

// MARK: - UI config
extension SearchContainer {
  
  private func setupAppearance() {
    searchTextField.attributedPlaceholder = NSAttributedString(string: "Поиск",
                                                               attributes: [.foregroundColor: UIColor.blueBell])
    borderView.setBorder(color: .blueBell, width: 1, cornerRadius: 5)
    searchButtonBorder.setBorder(color: .blueBell, width: 1, cornerRadius: 5)
  }
  
  private func updateUI(for state: SearchContainerStates) {
    switch state {
    case .short:
      UIView.animate(withDuration: 0.5,
                     delay: 0.0,
                     options: [],
                     animations: { [weak self] in
        self?.borderView.alpha = 0
        self?.searchButtonBorder.alpha = 1
      })
      
      UIView.transition(with: searchTextField,
                        duration: 0.5,
                        options: .transitionCrossDissolve,
                        animations: { [weak self] in
        self?.searchTextField.font = UIFont.systemFont(ofSize: 16)
      })
      
    case .long:
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [],
                       animations: { [weak self] in
          self?.borderView.alpha = 1
          self?.searchButtonBorder.alpha = 0
        })
        
        
        UIView.transition(with: searchTextField,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
          self?.searchTextField.font = UIFont.systemFont(ofSize: 18)
        })
    }
  }
  
}

// MARK: - UITextFieldDelegate
extension SearchContainer: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    state = .long
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let text = textField.text, !text.isEmpty else {
      state = .long
      return
    }
    state = .short
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    guard let text = textField.text, !text.isEmpty else { return true }
    delegate?.didPressReturn?(text)
    return true
  }
  
}
