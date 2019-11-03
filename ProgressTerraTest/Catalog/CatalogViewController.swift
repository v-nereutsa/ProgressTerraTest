//
//  ViewController.swift
//  ProgressTerraTest
//
//  Created by Владимир Нереуца on 31.10.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

import UIKit
import Alamofire

final class CatalogViewController: UIViewController {
  
  @IBOutlet weak var productsCount: UILabel!
  
  static let catalogItemCell = "ProductsCell"
  
  @IBOutlet private weak var searchContainer: SearchContainer!
  @IBOutlet private weak var contentTable: UITableView!
  
  private let delegate = CatalogViewControllerDelegate()
  private var dataSource: [Product] = []
  
}

// MARK: - Life cycle
extension CatalogViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAppearance()
    delegateSettings()
  }
  
}

// MARK: - Events
extension CatalogViewController {
  
  func delegateSettings() {
    delegate.succes = { [weak self] resultData in
      self?.dataSource = resultData.listProducts
      self?.productsCount.text = "Общее количество: \(resultData.listProducts.endIndex)"
      self?.productsCount.alpha = 1
      self?.contentTable.reloadData()
    }
    
    delegate.failure = { [weak self] error in
      self?.okAlert(title: "Ошибка \((error as NSError).code)", message: "Попробуйте позже.")
    }
    
    delegate.update = { [weak self] in
      guard let self = self else { return }
      let updatedData = self.dataSource + $0.listProducts
      self.contentTable.beginUpdates()
      self.dataSource = updatedData
      self.productsCount.text = "Общее количество: \(updatedData.endIndex)"
      let indexPaths = (updatedData.endIndex - $0.listProducts.endIndex ..< updatedData.endIndex).map { IndexPath(row: $0, section: 0) }
      self.contentTable.insertRows(at: indexPaths, with: .automatic)
      self.contentTable.endUpdates()
    }
  }
  
}

// MARK: - UI config
extension CatalogViewController {
  
  private func setupAppearance() {
    addTapGestureRecognizer()
    setupTableView()
    searchContainer.delegate = delegate.searchContainerDelegate
  }
  
  private func addTapGestureRecognizer() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    view.addGestureRecognizer(tapGesture)
  }
  
  private func setupTableView() {
    contentTable.dataSource = self
    contentTable.delegate = self
    
    contentTable.tableFooterView = UIView()
  }
  
}

// MARK: - UITableViewDataSource
extension CatalogViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.endIndex
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CatalogViewController.catalogItemCell, for: indexPath)
    cell.textLabel?.text = dataSource[indexPath.row].name
    return cell
  }
  
}

// MARK: - UITableViewDelegate
extension CatalogViewController: UITableViewDelegate {
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                 withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    let targetOffsetY = targetContentOffset.pointee.y
    let scrollViewHeight = scrollView.frame.size.height
    
    if scrollView.contentSize.height <= scrollViewHeight {
      delegate.needToLoadNextPage?()
    } else if scrollView.contentSize.height > scrollViewHeight {
      let maxOffset = scrollView.contentSize.height - scrollViewHeight
      if targetOffsetY > maxOffset - 100 {
        delegate.needToLoadNextPage?()
      }
    }
  }
  
}
