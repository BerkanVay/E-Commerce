//
//  ShopingBagTableViewModel.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 2.11.2022.
//

import Foundation
class ShoppingBagViewModel {
  weak var delegate: ShoppingBagViewDelegate?
  var productIds: [Int] = UserDefaults.standard.object(forKey: "baggedIds") as! [Int]
  var productInBag: [Product]? = nil 
  var totalPrice: Double {
    bagPrice()
  }
  var productResponse: ProductResponse? = nil {
    didSet {
      productInBag = seperateBag()
    }
  }
  
  private func seperateBag() -> [Product] {
    guard let productResponse = productResponse else { return [] }
    let filteredProducts = productResponse.products.filter { product in
      return BagStorage.contains(id: product.id)
    }
    return filteredProducts
  }
  
  private func bagPrice() -> Double {
    guard let productInBag else { return 0 }
    let prices = productInBag.map { product in
      product.price
    }
    return prices.reduce(0, {$0 + $1})
  }
  
  func removeProductInBag(id: Int) {
    productInBag?.removeAll{ product in
      return product.id == id
    }
  }
}
