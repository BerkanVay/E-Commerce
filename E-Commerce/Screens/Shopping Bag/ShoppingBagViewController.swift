//
//  ShoppingBagViewController.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 2.11.2022.
//

import UIKit

class ShoppingBagViewController: UIViewController{
  
  var viewModel = ShoppingBagViewModel()
  
  @IBOutlet private weak var amountLabel: UILabel!
  @IBOutlet private weak var itemCountLabel: UILabel!
  @IBOutlet private weak var tableView: UITableView!
  @IBOutlet weak var orderButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    configurate()
    updateButtonStatus()
  }
}

extension ShoppingBagViewController {
  private func setup() {
    tableView.register(UINib(nibName: "ShoppingBagTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    self.tableView.delegate = self
    self.tableView.dataSource = self
    viewModel.delegate = self
  }
  
  private func configurate() {
    title = "Your Bag"
    var itemCountLabelTextFormatter: String {
      viewModel.productInBag?.count == 1 ? "There is 1 product in bag" : "There are \(viewModel.productInBag?.count ?? 0) product in bag."
    }
    itemCountLabel.text = itemCountLabelTextFormatter
    amountLabel.text = "Total Price: \(Float(viewModel.totalPrice)) USD"
    let tableBackgroundView = UITextView(frame: CGRect(x: 0 , y: 0, width: 100, height: 100))
    tableBackgroundView.text = "Your bag is empty. Please add a product to order."
    tableBackgroundView.font = UIFont(name: "Helvetica", size: 15)
    tableView.backgroundView = tableBackgroundView
  }
}

extension ShoppingBagViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    (viewModel.productInBag?.count)!
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ShoppingBagTableViewCell else { return UITableViewCell()}
    cell.item = viewModel.productInBag?[indexPath.row]
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      guard let productInBag = viewModel.productInBag else { return }
      viewModel.removeProductInBag(id: (productInBag[indexPath.row].id))
      BagStorage.remove(id: (productInBag[indexPath.row].id))
      tableView.deleteRows(at: [indexPath], with: .fade)
      updateViews()
      updateButtonStatus()
    }
  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showOrderCofirmanition" {
      let destinationViewController = segue.destination as? OrderCofirmanitionViewController
      destinationViewController?.totalItemCount = viewModel.productInBag?.count
      destinationViewController?.totalAmount = viewModel.totalPrice
      
    }
  }
}

extension ShoppingBagViewController: ShoppingBagViewDelegate {
  func updateViews() {
    var itemCountLabelTextFormatter: String {
      viewModel.productInBag?.count == 1 ? "There is 1 product in bag" : "There are \(viewModel.productInBag?.count ?? 0) product in bag."
    }
    itemCountLabel.text = itemCountLabelTextFormatter
    amountLabel.text = "Total Price: \(Float(viewModel.totalPrice)) USD"
  }
  
  private func updateButtonStatus() {
    if viewModel.productInBag?.count == 0 {
      orderButton.isEnabled = false
    } else {
      orderButton.isEnabled = true
    }
  }
}
