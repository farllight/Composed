//
//  ComposedTableViewDataSource+UITableViewDataSource.swift
//  Composed
//
//  Created by Vladislav Markov on 31.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit

extension ComposedTableViewDataSource: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSources.reduce(0) { $0 + $1.numberOfSections }
    }
    
    // MARK: - Cells in section
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataSource = self.decompose(section: section)
        return dataSource.tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView(tableView, cellForRowAt: indexPath)
    }
    
    
    // MARK: - Titles header/footer in section
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dataSource = self.decompose(section: section)
        return dataSource.tableView?(tableView, titleForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let dataSource = self.decompose(section: section)
        return dataSource.tableView?(tableView, titleForFooterInSection: section)
    }
    
    // MARK: - Indexes for sections
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        let dataSource = self.decompose(section: index)
        return dataSource.tableView?(tableView, sectionForSectionIndexTitle: title, at: index) ?? index
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.dataSources.reduce([]) { $0 + ($1.sectionIndexTitles?(for: tableView) ?? []) }
    }
        
    // MARK: - Editing rows
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, canEditRowAt: indexPath) ?? false
    }
    
    // MARK: - Moving rows
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: sourceIndexPath)
        dataSource.tableView?(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, canMoveRowAt: indexPath) ?? false
    }
}
