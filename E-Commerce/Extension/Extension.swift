//
//  Extension.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 3.11.2022.
//

import UIKit

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
