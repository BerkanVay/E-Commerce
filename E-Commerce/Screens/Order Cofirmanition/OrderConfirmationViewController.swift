//
//  OrderConfirmationViewController.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 2.11.2022.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
  @IBOutlet private weak var itemCountLabel: UILabel!
  @IBOutlet private weak var totalAmountLabel: UILabel!
  
  var totalItemCount: Int?
  var totalAmount: Double?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Order Confirmation"
    guard let totalItemCount, let totalAmount else { return }
    itemCountLabel.text = totalItemCount == 1 ? "You order 1 product" : "You order \(totalItemCount) products."
    totalAmountLabel.text = "Total Price: \(Float(totalAmount)) USD"
  }
  
  @IBAction func closeButtonTapped(_ sender: Any) {
    FavoriteStorage.removeAll()
    BagStorage.removeAll()
    navigationController?.popToViewController(ofClass: ProductTableViewController.self)
  }
}
