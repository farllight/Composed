//
//  ComposableDataSource.swift
//  Composed
//
//  Created by Vladislav Markov on 30.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

public protocol ComposableDataSource: class {
    var numberOfSections: Int { get }
    
    func numberOfRows(for section: Int) -> Int
}
