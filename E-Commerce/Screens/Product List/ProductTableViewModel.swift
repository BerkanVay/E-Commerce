//
//  ProductTableViewModel.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 1.11.2022.
//

import Foundation

class ProductTableViewModel {
  weak var delegate: ProductTableViewDelegate?
  var result: ProductResponse? {
    didSet {
      delegate?.reloadData()
    }
  }
  
  init() {
    self.fetchProduct()
  }
  
  func fetchProduct() {
    Task {
      result = try? await RESTClient.doRequest()
    }
  }
}
