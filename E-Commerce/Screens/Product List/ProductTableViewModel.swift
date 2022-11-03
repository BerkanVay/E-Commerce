//
//  ProductTableViewModel.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 1.11.2022.
//

import Foundation

class ProductTableViewModel {
  var result: ProductResponse? = nil
  
  init() {
    self.fetchProduct()
  }
  
  func fetchProduct() {
    Task {
      result = try? await RESTClient.doRequest()
    }
  }
}
