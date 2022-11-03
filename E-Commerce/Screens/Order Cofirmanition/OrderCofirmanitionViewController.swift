//
//  OrderCofirmanitionViewController.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 2.11.2022.
//

import UIKit

class OrderCofirmanitionViewController: UIViewController {
  
  @IBOutlet weak var itemCountLabel: UILabel!
  @IBOutlet weak var totalAmountLabel: UILabel!
  
  var totalItemCount: Int?
  var totalAmount: Double?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Order Corfirmanition"
    guard let totalItemCount, let totalAmount else { return }
    var itemCountLabelTextFormatter: String {
      totalItemCount == 1 ? "You order 1 product" : "You order \(totalItemCount) products."
    }
    itemCountLabel.text = itemCountLabelTextFormatter
    totalAmountLabel.text = "Total Price: \(Float(totalAmount)) USD"
  }
  
  @IBAction func closeButtonTapped(_ sender: Any) {
    FavoriteStorage.removeAll()
    BagStorage.removeAll()
    let tableViewController = ProductTableViewController()
    navigationController?.popToViewController(ofClass: ProductTableViewController.self)
  }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
