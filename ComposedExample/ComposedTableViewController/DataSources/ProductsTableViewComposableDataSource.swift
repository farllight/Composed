//
//  ProductsTableViewComposableDataSource.swift
//  ComposedExample
//
//  Created by Vladislav Markov on 31.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit
import Composed

protocol ProductsTableViewComposableDataSourceDelegate: class {
    func dataSource(_ dataSource: ProductsTableViewComposableDataSource, select product: Product)
}

class ProductsTableViewComposableDataSource: NSObject, ComposableTableViewDataSource {
    var cellTypes: [UITableViewCell.Type] = [ProductTableViewCell.self]

    var numberOfSections = 1
    
    private unowned let delegate: ProductsTableViewComposableDataSourceDelegate
    private let products: [Product]
    
    init(_ products: [Product], delegate: ProductsTableViewComposableDataSourceDelegate) {
        self.products = products
        self.delegate = delegate
    }
    
    func numberOfRows(for section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: ProductTableViewCell.self, indexPath: indexPath)
        
        let product = self.products[indexPath.row]
        cell.setup(product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let product = self.products[indexPath.row]
        self.delegate.dataSource(self, select: product)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Products"
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["Products"]
    }
}
