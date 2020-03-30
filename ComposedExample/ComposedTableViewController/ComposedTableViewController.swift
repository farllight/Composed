//
//  ComposedTableViewController.swift
//  ComposedExample
//
//  Created by Vladislav Markov on 31.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit
import Composed

class ComposedTableViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let categories = ["Eat", "Electronic", "Home", "Clothes"]
    private let products = [
        Product(name: "Pencil", price: 120.0, count: 10, image: UIImage(systemName: "pencil")),
        Product(name: "Trash", price: 60.0, count: 1, image: UIImage(systemName: "trash"))
    ]
    
    private var composedDataSource: ComposedTableViewDataSource?
    
    // MARK: - Initialize
    init() {
        super.init(nibName: "ComposedTableViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        let composedDataSource = ComposedTableViewDataSource([
            CategoryTableViewComposableDataSource(self.categories),
            ProductsTableViewComposableDataSource(self.products, delegate: self)
        ])
        
        self.tableView.tableFooterView = UIView()
        
        self.composedDataSource = composedDataSource
        self.tableView.setComposedDataSource(composedDataSource)
        self.tableView.reloadData()
    }
}

extension ComposedTableViewController: ProductsTableViewComposableDataSourceDelegate {
    func dataSource(_ dataSource: ProductsTableViewComposableDataSource, select product: Product) {
        // Show screen with detail product
    }
}
