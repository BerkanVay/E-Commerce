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
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    tableView.reloadData()
  }
  
  private func setup() {
    viewModel.delegate = self
    title = "Momentup Store"
    navigationController?.navigationBar.prefersLargeTitles = true
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
    cell.isBag = BagStorage.contains(id: item.id)
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
    if BagStorage.contains(id: product.id){
      BagStorage.remove(id: product.id)
    } else {
      BagStorage.add(id: product.id)
    }
    tableView.reloadData()
  }
}

extension ProductTableViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetailView" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let destinationViewController = segue.destination as? ProductDetailViewController
        destinationViewController?.delegate = self
        guard let item = viewModel.result?.products[indexPath.row] else { return }
        destinationViewController?.isFavorite = FavoriteStorage.contains(id: item.id)
        destinationViewController?.isBag = BagStorage.contains(id: item.id)
        destinationViewController?.item = item
      }
    }
    if segue.identifier == "showBagView" {
      let destinationViewController = segue.destination as? ShoppingBagViewController
      destinationViewController?.viewModel.productResponse = viewModel.result
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetailView", sender: nil)
  }
  
  @IBAction func bagButtonTapped(_ sender: Any) {
    performSegue(withIdentifier: "showBagView", sender: nil)
  }
}
