//
//  SearchResponse.swift
//  ProgressTerraTest
//
//  Created by Владимир Нереуца on 03.11.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

import SwiftyJSON

struct SearchResponse {
  let countItemsInPage: Int
  let totalPage: Int
  let numberCurrentPage: Int
  let listProducts: [Product]
  
  init(data: JSON) {
    countItemsInPage = data["countItemsInPage"].intValue
    totalPage = data["totalPage"].intValue
    numberCurrentPage = data ["numberCurrentPage"].intValue
    let tempProducts = data["listProducts"].arrayValue.map { Product($0["idUnique"].stringValue,
                                                                     $0["idCategory"].stringValue,
                                                                     $0["name"].stringValue) }
    listProducts = tempProducts
  }

}

struct Product {
  init(_ idUnique: String, _ idCategory: String, _ name: String) {
    self.idUnique = idUnique
    self.idCategory = idCategory
    self.name = name
  }
  let idUnique: String
  let idCategory: String
  let name: String
}
