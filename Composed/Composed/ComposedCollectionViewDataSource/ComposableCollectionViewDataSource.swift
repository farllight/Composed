//
//  ComposableCollectionViewDataSource.swift
//  Composed
//
//  Created by Vladislav Markov on 24.03.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit

protocol ComposableCollectionViewDataSource: class, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var isHidden: Bool { get set }
    //Cell type
    var cellTypes: [UICollectionViewCell.Type] { get }
    //Header and footer type
    var headerFooterType: UICollectionReusableView.Type? { get }
    /// Current number of sections.
    var numberOfSections: Int { get }
    // Current number of section index titles.
    var numberOfSectionTitles: Int { get }

    func numberOfRows(for section: Int) -> Int
    func getKey() -> String
}

extension ComposableCollectionViewDataSource {
    func getKey() -> String {
        return "\(Self.self)"
    }

    func numberOfRows(for section: Int) -> Int {
        return 1
    }
}
