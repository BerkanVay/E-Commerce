//
//  ProductTableViewController.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 1.11.2022.
//

import UIKit

class ProductTableViewController: UITableViewController {
  
  private var viewModel = ProductTableViewModel()
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
  }
}

extension ProductTableViewController: ProductTableViewDelegate {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.result?.products.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ProductTableViewCell else { return UITableViewCell()}
    cell.item = viewModel.result?.products[indexPath.row]
    
    return cell
  }
  
  func reloadData() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }
}
