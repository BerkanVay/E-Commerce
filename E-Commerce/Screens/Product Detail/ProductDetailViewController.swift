//
//  ProductDetailViewController.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 2.11.2022.
//

import UIKit

class ProductDetailViewController: UIViewController {
  @IBOutlet private weak var priceLabel: UILabel!
  @IBOutlet private weak var colorLabel: UILabel!
  @IBOutlet private weak var categoryLabel: UILabel!
  @IBOutlet private weak var productImageView: UIImageView!
  
  @IBOutlet private weak var favoriteButton: UIButton!
  @IBOutlet private weak var bagButton: UIButton!
  
  var item: Product? = nil
  var isInBag = false
  var isFavorite = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  private func configure() {
    guard let item else { return }
    title = item.name
    productImageView.image = UIImage(named: item.imageName)
    priceLabel.text = "\(item.price) \(item.currency)"
    categoryLabel.text = item.category
    colorLabel.text = item.color
    setFavoriteButtonState(isFavorited: isFavorite)
    setBagButtonState(isInBag: isInBag)
  }
  
  private func setFavoriteButtonState(isFavorited: Bool) {
    let imageName = isFavorited ? "heart.fill" : "heart"
    
    favoriteButton.setImage(
      .init(systemName: imageName),
      for: .normal
    )
  }
  
  private func setBagButtonState(isInBag: Bool) {
    let imageName = isInBag ? "bag.fill" : "bag"
    let buttonText = isInBag ? "Remove from bag" : "Add to bag"
    
    bagButton.setTitle(buttonText, for: .normal)
    bagButton.setImage(
      .init(systemName: imageName),
      for: .normal
    )
  }
}

extension ProductDetailViewController {
  
  @IBAction private func bagButtonTapped(_ sender: Any) {
    guard let item = item else { return }
    if BagStorage.contains(id: item.id){
      BagStorage.remove(id: item.id)
    } else {
      BagStorage.add(id: item.id)
    }
    isInBag = BagStorage.contains(id: item.id)
    self.configure()
  }
  
  @IBAction private func favoriteButtonTapped(_ sender: Any) {
    guard let item = item else { return }
    if FavoriteStorage.contains(id: item.id){
      FavoriteStorage.remove(id: item.id)
    } else {
      FavoriteStorage.add(id: item.id)
    }
    isFavorite = FavoriteStorage.contains(id: item.id)
    self.configure()
  }
}

