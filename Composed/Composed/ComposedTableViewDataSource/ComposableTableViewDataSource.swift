//
//  ComposableTableViewDataSource.swift
//  Composed
//
//  Created by Vladislav Markov on 24.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit

protocol ComposableTableViewDataSource: class, UITableViewDataSource, UITableViewDelegate {
    var isHidden: Bool { get set }
    
    var cellTypes: [UITableViewCell.Type] { get }
    var headerFooterType: UITableViewHeaderFooterView.Type? { get }
    var numberOfSections: Int { get }
    var numberOfSectionTitles: Int { get }

    func numberOfRows(for section: Int) -> Int
    func getKey() -> String
}

extension ComposableTableViewDataSource {
    func getKey() -> String {
        return "\(Self.self)"
    }

    func numberOfRows(for section: Int) -> Int {
        return 1
    }
}
