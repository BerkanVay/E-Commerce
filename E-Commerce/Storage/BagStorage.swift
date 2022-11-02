//
//  BagStorage.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 2.11.2022.
//

import Foundation

class BagStorage {
  private static let userDefaultsKey = "baggedIds"
  
  private static var ids: [Int] {
    get {
      return UserDefaults.standard.object(forKey: userDefaultsKey) as? [Int] ?? []
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
    }
  }
  
  static func add(id: Int) {
    if contains(id: id) { return }
    
    ids.append(id)
  }
  
  static func remove(id: Int) {
    ids.removeAll { $0 == id }
  }
  
  static func removeAll() {
    ids.removeAll()
  }
  
  static func contains(id: Int) -> Bool {
    ids.contains(id)
  }
}
