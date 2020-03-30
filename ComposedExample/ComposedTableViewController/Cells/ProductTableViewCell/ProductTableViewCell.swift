//
//  ProductTableViewCell.swift
//  ComposedExample
//
//  Created by Vladislav Markov on 31.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    func setup(_ model: Product) {
        self.iconImageView.image = model.image
        self.nameLabel.text = model.name
        self.countLabel.text = String(model.count)
        self.priceLabel.text = String(model.price)
    }
}
