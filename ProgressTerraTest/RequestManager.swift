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
  
  private var headers: HTTPHeaders = ["AccessKey": "test_05fc5ed1-0199-4259-92a0-2cd58214b29c",
                                      "IDCategory": "",
                                      "IDClient": "",
                                      "pageNumberIncome": "1",
                                      "pageSizeIncome": "12"]
  
  func loadData(_ searchString: String, completion: @escaping ((Result<SearchResponse, AFError>) -> Void)) {
    let parameters: Parameters = ["SearchString": searchString]
    AF.request("http://iswiftdata.1c-work.net/api/products/searchproductsbycategory",
               method: .get,
               parameters: parameters,
               encoding: URLEncoding.default,
               headers: headers,
               interceptor: nil)
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


