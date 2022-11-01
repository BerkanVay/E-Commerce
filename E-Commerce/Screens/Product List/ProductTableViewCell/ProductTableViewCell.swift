//
//  ProductTableViewCell.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 1.11.2022.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
  @IBOutlet private weak var productImageView: UIImageView!
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var priceLabel: UILabel!
  @IBOutlet private weak var bagButton: UIButton!
  @IBOutlet private weak var favoriteButton: UIButton!
  
  
  var item: Product? = nil
  var delegate: ProductTableViewCellDelegate?
  var isFavorite: Bool = false
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    configurate()
    setFavoriteButtonState(isFavorited: isFavorite)
  }
  
  private func configurate(){
    guard let item else { return }
    productImageView.image = UIImage(named: item.imageName)
    nameLabel.text = item.name
    priceLabel.text = String(item.price) + " " + item.currency
  }
  
  private func setFavoriteButtonState(isFavorited: Bool) {
    let imageName = isFavorited ? "heart.fill" : "heart"
    
    favoriteButton.setImage(
      .init(systemName: imageName),
      for: .normal
    )
  }
}

extension ProductTableViewCell {
  @IBAction private func bagButtonTapped(_ sender: Any) {
    guard let item = item else { return }
    delegate?.bagButtonTapped(forProduct: item)
  }
  @IBAction private func favoriteButtonTapped(_ sender: Any) {
    guard let item = item else { return }
    delegate?.favoriteButtonTapped(forProduct: item)
  }
}
