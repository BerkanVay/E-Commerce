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
  
  var item: Product? = nil
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    configurate()
  }
  
  private func configurate(){
    guard let item else { return }
    productImageView.image = UIImage(named: item.imageName)
    nameLabel.text = item.name
    priceLabel.text = String(item.price) + " " + item.currency
  }
}
