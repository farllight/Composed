//
//  CategoryTableViewCell.swift
//  ComposedExample
//
//  Created by Vladislav Markov on 31.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    func setup(_ title: String) {
        self.titleLabel.text = title
    }
}
