//
//  CatalogViewControllerDelegate.swift
//  ProgressTerraTest
//
//  Created by Владимир Нереуца on 03.11.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

import Alamofire

protocol CatalogControllerDelegateProtocol: AnyObject {
  
  var succes: ((SearchResponse) -> Void)? { get set }
  var failure: ((Error) -> Void)? { get set }
  var update: ((SearchResponse) -> Void)? { get set }
  
  func loadData(for searchText: String)
  
}

final class CatalogViewControllerDelegate: CatalogControllerDelegateProtocol {
  
  var textForSearch = ""
  
  var succes: ((SearchResponse) -> Void)?
  var failure: ((Error) -> Void)?
  var update: ((SearchResponse) -> Void)?
  var delete: (() -> Void)?
  
  var needToLoadNextPage: (() -> Void)?
  
  let searchContainerDelegate: SearchContainerDelegate
  
  init() {
    searchContainerDelegate = SearchContainerDelegate()
    setupClosures()
  }
  
  func setupClosures() {
    searchContainerDelegate.didPressReturn = { [weak self] in
      print("is main thread: ", Thread.isMainThread)
      self?.loadData(for: $0)
    }
    
    searchContainerDelegate.clearTable = { [weak self] in
      self?.deleteData()
    }
    
    needToLoadNextPage = { [weak self] in
      // проверить
      print("is main thread: ", Thread.isMainThread)
      self?.loadNextPage()
    }
  }
  
}

// MARK: - Network request
extension CatalogViewControllerDelegate {
  
  func loadData(for searchText: String) {
    textForSearch = searchText
    RequestManager.shared
      .loadData(searchText) { [weak self] result in
        switch result {
        case .success(let response):
          self?.succes?(response)
          
        case .failure(let error):
          self?.failure?(error)
        }
    }
  }
  
  func deleteData(){
    self.delete?()
  }
  
  func loadNextPage() {
    RequestManager.shared
      .loadNextPage(textForSearch, completion: { [weak self] result in
        switch result {
        case .success(let response):
          self?.update?(response)
          
        case .failure(let error):
          self?.failure?(error)
        }
      })
  }
  
}
