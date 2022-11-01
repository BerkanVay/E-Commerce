//
//  ProductResponse.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 1.11.2022.
//

import Foundation

struct ProductResponse: Decodable {
  let products: [Product]
}

struct Product: Decodable {
  let id: Int
  let price: Double
  let name: String
  let currency: String
  let imageName: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case price
    case name
    case currency
    case imageName = "image_name"
  }
}

