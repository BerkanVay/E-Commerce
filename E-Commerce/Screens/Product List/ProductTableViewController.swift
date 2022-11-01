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
    guard let item = viewModel.result?.products[indexPath.row] else {
      return UITableViewCell()
    }
    cell.item = item
    cell.delegate = self
    cell.isFavorite = FavoriteStorage.contains(id: item.id)
    return cell
  }
  
  func reloadData() {
    DispatchQueue.main.async {
      self.reloadData()
    }
  }
}

extension ProductTableViewController: ProductTableViewCellDelegate {
  func favoriteButtonTapped(forProduct product: Product) {
    if FavoriteStorage.contains(id: product.id){
      FavoriteStorage.remove(id: product.id)
    } else {
      FavoriteStorage.add(id: product.id)
    }
    tableView.reloadData()
  }
  
  func bagButtonTapped(forProduct product: Product) {
    self.reloadData()
  }
  
}
