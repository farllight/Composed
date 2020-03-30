//
//  ComposedTableViewDataSource.swift
//  Composed
//
//  Created by Vladislav Markov on 30.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit

public protocol ComposableTableViewDataSource: ComposableDataSource, UITableViewDataSource, UITableViewDelegate {
    var cellTypes: [UITableViewCell.Type] { get }
}

public class ComposedTableViewDataSource: NSObject {
    let decomposer: Decomposer
    let dataSources: [ComposableTableViewDataSource]
    
    var cellTypes: [UITableViewCell.Type] {
        return self.dataSources.map { $0.cellTypes }.flatMap { $0 }
    }
    
    public init(_ dataSources: [ComposableTableViewDataSource]) {
        self.dataSources = dataSources
        self.decomposer = Decomposer(dataSources)
    }
}

// MARK: - Decompose methods
internal extension ComposedTableViewDataSource {
    func decompose(section: Int) -> ComposableTableViewDataSource {
        return self.decomposer.decompose(section: section) as! ComposableTableViewDataSource
    }
    
    func decompose(indexPath: IndexPath) -> ComposableTableViewDataSource {
        return self.decomposer.decompose(indexPath: indexPath) as! ComposableTableViewDataSource
    }
}



