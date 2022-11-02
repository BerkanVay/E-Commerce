//
//  ProductTableViewCellDelegate.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 1.11.2022.
//

import Foundation

protocol ProductTableViewCellDelegate: AnyObject {
  func favoriteButtonTapped(forProduct product : Product)
  func bagButtonTapped(forProduct product: Product)
}
