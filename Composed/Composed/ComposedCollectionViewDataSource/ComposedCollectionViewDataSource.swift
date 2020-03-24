//
//  ComposedCollectionViewDataSource.swift
//  Composed
//
//  Created by Vladislav Markov on 24.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit

// MARK: - Composed Data Source
/**
 Data source that can be composed of multiple original data source objects.
 Rows movements is not supported, updates observation is under implementation.
 */
class ComposedCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties
    private var dataSources: [ComposableCollectionViewDataSource]

    var cellTypes: [UICollectionViewCell.Type] {
        let cellTypes = self.dataSources.compactMap { $0.cellTypes }.flatMap { $0 }
        return cellTypes
    }

    var headerFooterTypes: [UICollectionReusableView.Type]? {
        let types = self.dataSources.compactMap { $0.headerFooterType }
        return types
    }

    // MARK: - Initialization
    // MARK: ComposedCollectionViewDataSource protocol initializers

    /**
     Initializes and returns composed data source object.
     - parameter dataSources: Any number of data source objects to be composed can be passed as an array or comma separated list.
     */
    init(dataSources: [ComposableCollectionViewDataSource]) {
        self.dataSources = dataSources
        super.init()
    }

    private override init() {
        fatalError("ComposedCollectionViewDataSource: Initializer with parameters must be used.")
    }

    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSources.reduce(0) { $0 + ($1.numberOfSections?(in: collectionView) ?? 1) }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adduce(section) { return $0.isHidden ? 0 : $0.collectionView(collectionView, numberOfItemsInSection: $1) }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return adduce(indexPath) { return $0.collectionView(collectionView, cellForItemAt: $1) }
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return adduce(indexPath) { return $0.collectionView?(collectionView, didSelectItemAt: $1) }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return adduce(indexPath) { return $0.collectionView?(collectionView, layout: collectionViewLayout, sizeForItemAt: $1) ?? UICollectionViewFlowLayout.automaticSize }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return adduce(section) { return $0.collectionView?(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: $1) ?? 0.0}
    }

    // MARK: - Private methods
    private typealias SectionNumber = Int

    private typealias AdducedSectionTask<T> = (_ composableDataSource: ComposableCollectionViewDataSource, _ sectionNumber: SectionNumber) -> T

    private func adduce<T>(_ section: SectionNumber, _ task: AdducedSectionTask<T>) -> T {
        let (dataSource, decomposedSection) = decompose(section: section)
        return task(dataSource, decomposedSection)
    }

    private typealias AdducedIndexPathTask<T> = (_ composableDataSource: ComposableCollectionViewDataSource, _ indexPath: IndexPath) -> T

    private func adduce<T>(_ indexPath: IndexPath, _ task: AdducedIndexPathTask<T>) -> T {
        let (dataSource, _) = decompose(section: indexPath.section)
        return task(dataSource, IndexPath(row: indexPath.row, section: indexPath.section))
    }

    private func decompose(section: SectionNumber) -> (dataSource: ComposableCollectionViewDataSource, decomposedSection: SectionNumber) {
        var section = section
        var dataSourceIndex = 0
        for (index, dataSource) in dataSources.enumerated() {
            let diff = section - dataSource.numberOfSections
            dataSourceIndex = index
            if diff < 0 { break } else { section = diff }
        }

        return (dataSources[dataSourceIndex], section)
    }

    private func adduceTitleIndex<T>(_ sectionTitleIndex: Int, _ task: AdducedSectionTask<T>) -> T {
        let (dataSource, decomposedSectionTitleIndex) = decompose(sectionTitleIndex: sectionTitleIndex)
        return task(dataSource, decomposedSectionTitleIndex)
    }

    private func decompose(sectionTitleIndex: Int) -> (dataSource: ComposableCollectionViewDataSource, decomposedSection: SectionNumber) {
        var titleIndex = sectionTitleIndex
        var dataSourceIndex = 0
        for (index, dataSource) in dataSources.enumerated() {
            let diff = titleIndex - dataSource.numberOfSectionTitles
            dataSourceIndex = index
            if diff < 0 { break } else { titleIndex = diff }
        }

        return (dataSources[dataSourceIndex], titleIndex)
    }
}

