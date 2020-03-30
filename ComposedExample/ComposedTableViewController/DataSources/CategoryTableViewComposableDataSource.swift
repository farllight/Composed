//
//  CategoryTableViewComposableDataSource.swift
//  ComposedExample
//
//  Created by Vladislav Markov on 31.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit
import Composed

class CategoryTableViewComposableDataSource: NSObject, ComposableTableViewDataSource {
    var cellTypes: [UITableViewCell.Type] = [CategoryTableViewCell.self]
    
    var numberOfSections = 3
    
    let categories: [String]
    
    init(_ categories: [String]) {
        self.categories = categories
    }
    
    func numberOfRows(for section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(type: CategoryTableViewCell.self, indexPath: indexPath)
        
        let category = self.categories[indexPath.row]
        cell.setup(category)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["Categories", "Categories", "Categories"]
    }
    
}
