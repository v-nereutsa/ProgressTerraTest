//
//  RequestManager.swift
//  ProgressTerraTest
//
//  Created by Владимир Нереуца on 03.11.2019.
//  Copyright © 2019 Владимир Нереуца. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class RequestManager {
  
  static let shared = RequestManager()
  
  var currentPage = 1
  var totalPages: Int?
  
  private var headers: HTTPHeaders = ["AccessKey": "test_05fc5ed1-0199-4259-92a0-2cd58214b29c",
                                      "IDCategory": "",
                                      "IDClient": "",
                                      "pageNumberIncome": "1",
                                      "pageSizeIncome": "30"]
  
  func loadData(_ searchString: String, completion: @escaping ((Swift.Result<SearchResponse, Error>) -> Void)) {
    currentPage = 1
    headers["pageNumberIncome"] = String(currentPage)
    let parameters: Parameters = ["SearchString": searchString]

    Alamofire.request("http://iswiftdata.1c-work.net/api/products/searchproductsbycategory",
                      method: .get,
                      parameters: parameters,
                      encoding: URLEncoding.default,
                      headers: headers)
      .validate()
      .responseJSON { [weak self] responseJSON in
        switch responseJSON.result {
        case .success(let value):
          let json = JSON(value)
          let response = SearchResponse(data: json)
          self?.totalPages = response.totalPage
          completion(.success(response))
          
        case .failure(let error):
          completion(.failure(error))
        }
    }
  }
  
  func loadNextPage(_ searchString: String, completion: @escaping ((Swift.Result<SearchResponse, Error>) -> Void)) {
    currentPage += 1
    headers["pageNumberIncome"] = String(currentPage)
    let parameters: Parameters = ["SearchString": searchString]

    Alamofire.request("http://iswiftdata.1c-work.net/api/products/searchproductsbycategory",
                      method: .get,
                      parameters: parameters,
                      encoding: URLEncoding.default,
                      headers: headers)
      .validate()
      .responseJSON { responseJSON in
        switch responseJSON.result {
        case .success(let value):
          let json = JSON(value)
          let response = SearchResponse(data: json)
          completion(.success(response))
          
        case .failure(let error):
          completion(.failure(error))
        }
    }
    
  }
  
}


