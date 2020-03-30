//
//  UITableView+Ex.swift
//  Composed
//
//  Created by Vladislav Markov on 31.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit

// MARK: - Register Cells
public extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let id = String(describing: type)
        let nib = UINib(nibName: id, bundle: nil)
        self.register(nib, forCellReuseIdentifier: id)
    }
    
    func register(_ types: [UITableViewCell.Type]) {
        types.forEach(self.register)
    }
}

public extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath)
        return cell as! T
    }
    
    func setComposedDataSource(_ dataSource: ComposedTableViewDataSource) {
        self.register(dataSource.cellTypes)
        self.dataSource = dataSource
    }
}
