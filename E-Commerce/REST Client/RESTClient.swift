//
//  RESTClient.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 1.11.2022.
//

import Foundation

class RESTClient {
  private static let url = URL(string: "https://www.momentup.com/challange/ProductsWithFilter.json")
  
  enum NetworkingError: Error {
    case invalidURL
  }
  
  private static let jsonDecoder = JSONDecoder()
  
  static func doRequest() async throws -> ProductResponse {
    guard let url else {
      throw NetworkingError.invalidURL
    }
    let (data, _) = try await URLSession.shared.data(from: url)

    return try jsonDecoder.decode(ProductResponse.self, from: data)
  }
}
