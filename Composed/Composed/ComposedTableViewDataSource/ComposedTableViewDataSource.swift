//
//  ComposedTableViewDataSource.swift
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
protocol ComposedTableViewDataSourceDelegate: class {
    func sourceUpdated(_ сomposedTableViewDataSource: ComposedTableViewDataSource, сomposableTableViewDataSource: ComposableTableViewDataSource, indexSet: IndexSet)
}

class ComposedTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    // MARK: - Properties
    private var dataSources: [ComposableTableViewDataSource]

    weak var delegate: ComposedTableViewDataSourceDelegate?

    var cellTypes: [UITableViewCell.Type] {
        let cellTypes = self.dataSources.compactMap { $0.cellTypes }.flatMap { $0 }
        return cellTypes
    }

    var headerFooterTypes: [UITableViewHeaderFooterView.Type]? {
        let types = self.dataSources.compactMap { $0.headerFooterType }
        return types
    }

    // MARK: - Initialization
    // MARK: ComposedTableViewDataSource protocol initializers

    /**
     Initializes and returns composed data source object.
     - parameter dataSources: Any number of data source objects to be composed can be passed as an array or comma separated list.
     */
    init(dataSources: [ComposableTableViewDataSource]) {
        self.dataSources = dataSources
        super.init()
    }

    private override init() {
        fatalError("ComposedTableViewDataSource: Initializer with parameters must be used.")
    }

    // MARK: - Methods

    // MARK: ComposedTableViewDataSource protocol methods

    // Configuring a Table View

    func numberOfSections(in tableView: UITableView) -> Int {
        // Default value if not implemented is "1".
        return dataSources.reduce(0) { $0 + ($1.numberOfSections?(in: tableView) ?? 1) }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return adduce(section) { $0.tableView?(tableView, titleForHeaderInSection: $1) }
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return adduce(section) { $0.tableView?(tableView, titleForFooterInSection: $1) }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return adduce(section) {
            return $0.isHidden ? nil: $0.tableView?(tableView, viewForHeaderInSection: $1)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return adduce(section) { $0.tableView?(tableView, heightForHeaderInSection: $1) ?? CGFloat.leastNormalMagnitude }
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return adduce(section) {
            return $0.isHidden ? nil: $0.tableView?(tableView, viewForFooterInSection: $1)
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return adduce(section) { $0.tableView?(tableView, heightForFooterInSection: $1) ?? CGFloat.leastNormalMagnitude }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adduce(section) { return $0.isHidden ? 0: $0.tableView(tableView, numberOfRowsInSection: $1) }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return adduce(indexPath) { $0.tableView(tableView, cellForRowAt: $1) }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return adduce(indexPath) { $0.tableView?(tableView, didSelectRowAt: $1) }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return adduce(indexPath) { $0.tableView?(tableView, heightForRowAt: $1) ?? UITableView.automaticDimension }
    }
    
    // Inserting or Deleting Table Rows
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        return adduce(indexPath) { $0.tableView?(tableView, commit: editingStyle, forRowAt: $1) }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Default if not implemented is "false".
        return adduce(indexPath) { $0.tableView?(tableView, canEditRowAt: $1) ?? false }
    }
    
    // Reordering Table Rows

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        /*
         Movement is disabled because different data source objects can operate different object types, hence there's no possibility to move a corresponding object from one data source to another. At this moment there's no way to figure out wether movement occurs within a single data source bounds.
         */
        return false
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        /*
         There's no possibility to interrupt movement within data source object. This method responsibility is to handle movement accordingly row's relocation.
         */
    }

    // Configuring an Index
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataSources.reduce([String]()) { $0 + ($1.sectionIndexTitles?(for: tableView) ?? [String]()) }
    }

    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return adduceTitleIndex(index) { $0.tableView!(tableView, sectionForSectionIndexTitle: title, at: $1) }
    }

    // MARK: Private methods

    private typealias SectionNumber = Int

    private typealias AdducedSectionTask<T> = (_ composableDataSource: ComposableTableViewDataSource, _ sectionNumber: SectionNumber) -> T

    private func adduce<T>(_ section: SectionNumber, _ task: AdducedSectionTask<T>) -> T {
        let (dataSource, decomposedSection) = decompose(section: section)
        return task(dataSource, decomposedSection)
    }

    private typealias AdducedIndexPathTask<T> = (_ composableDataSource: ComposableTableViewDataSource, _ indexPath: IndexPath) -> T

    private func adduce<T>(_ indexPath: IndexPath, _ task: AdducedIndexPathTask<T>) -> T {
        let (dataSource, _) = decompose(section: indexPath.section)
//        return task(dataSource, IndexPath(row: indexPath.row, section: decomposedSection)) // в этом месте decomposedSection заменили на indexPath.section так как иначе прилодение падало на попытке собрать ячейку для второй секции
        return task(dataSource, IndexPath(row: indexPath.row, section: indexPath.section))
    }

    private func decompose(section: SectionNumber) -> (dataSource: ComposableTableViewDataSource, decomposedSection: SectionNumber) {
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

    private func decompose(sectionTitleIndex: Int) -> (dataSource: ComposableTableViewDataSource, decomposedSection: SectionNumber) {
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

extension Array where Element == ComposableTableViewDataSource {
    mutating func add(_ item: ComposableTableViewDataSource?) {
        guard let item = item else { return }
        self.append(item)
    }
}

extension ComposedTableViewDataSource {
    func getSource<T>() -> T? {
        return self.dataSources as? T
    }

    func deactivate(_ source: ComposableTableViewDataSource?) {
        self.deactivateOrActivate(source, isHidden: true)
    }

    func activate(_ source: ComposableTableViewDataSource?) {
        self.deactivateOrActivate(source, isHidden: false)
    }

    func activateAllSources() {
        self.dataSources.forEach { $0.isHidden = false }
    }

    func refresh(_ source: ComposableTableViewDataSource?) {
        guard let source = source else { return }
        let key = "\(source.getKey())"
        for (var index, dataSource) in dataSources.enumerated() where dataSource.getKey() == key && !dataSource.isHidden {
            let startIndex = index
            index += dataSource.numberOfSections - 1
            let indexSet: IndexSet = index == startIndex ? IndexSet(arrayLiteral: startIndex) : IndexSet(integersIn: startIndex..<index)
            self.delegate?.sourceUpdated(self, сomposableTableViewDataSource: dataSource, indexSet: indexSet)
        }
    }

    private func deactivateOrActivate(_ source: ComposableTableViewDataSource?, isHidden: Bool) {
        guard let source = source else { return }
        let key = "\(source.getKey())"
        for (var index, dataSource) in dataSources.enumerated() where dataSource.getKey() == key && dataSource.isHidden != isHidden {
            dataSource.isHidden.toggle()
            let startIndex = index
            index += dataSource.numberOfSections - 1
            let indexSet: IndexSet = index == startIndex ? IndexSet(arrayLiteral: startIndex) : IndexSet(integersIn: startIndex..<index)
            self.delegate?.sourceUpdated(self, сomposableTableViewDataSource: dataSource, indexSet: indexSet)
        }
    }
}

