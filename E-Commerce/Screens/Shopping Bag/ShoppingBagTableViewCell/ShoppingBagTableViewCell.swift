//
//  ShoppingBagTableViewCell.swift
//  E-Commerce
//
//  Created by Mustafa Berkan Vay on 2.11.2022.
//

import UIKit

class ShoppingBagTableViewCell: UITableViewCell {

  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!

  var item: Product? = nil
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      configurate()
    }
    
  private func configurate() {
    guard let item else { return }
    productImageView.image = UIImage(named: item.imageName)
    nameLabel.text = item.name
    priceLabel.text = String(item.price) + " " + item.currency
  }
}
