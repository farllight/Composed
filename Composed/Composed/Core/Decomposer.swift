//
//  Decomposer.swift
//  Composed
//
//  Created by Vladislav Markov on 30.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

internal class Decomposer {
    var dataSources: [ComposableDataSource]
    
    init(_ dataSources: [ComposableDataSource]) {
        self.dataSources = dataSources
    }

    func decompose(indexPath: IndexPath) -> ComposableDataSource {
        let section = indexPath.section
        return self.decompose(section: section)
    }
    
    func decompose(section: Int) ->  ComposableDataSource {
        var section = section
        var dataSourceIndex = 0
        
        for (index, dataSource) in self.dataSources.enumerated() {
            let diff = section - dataSource.numberOfSections
            dataSourceIndex = index
            if diff < 0 { break } else { section = diff }
        }
        
        return self.dataSources[dataSourceIndex]
    }
}
