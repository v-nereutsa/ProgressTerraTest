//
//  CatalogViewControllerDelegate.swift
//  ProgressTerraTest
//
//  Created by Владимир Нереуца on 03.11.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

final class CatalogViewControllerDelegate: CatalogControllerDelegateProtocol {
  
  var searchContainerDelegate: SearchContainerDelegate?
  
  // success: (Type) -> Void
  // error:   (Error) -> Void
  
  var text: String = ""
  
  init() {
    // 
  }
  
  func setupClosures() {
    
  }
  
  func loadData() {
    // requestManager
  }
  
  // Result<Data, Error>
  private func handleRequest() {
  }
  
}
