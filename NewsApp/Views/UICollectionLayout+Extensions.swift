//
//  UICollectionLayout+Extensions.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 19.04.2024.
//

import Foundation
import UIKit

extension UICollectionViewLayout {
    
    static var mainScreen: UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch Sections.dataSection(for: sectionIndex) {
            case .business, .entertainment, .general, .health, .nation, .science, .sports, .technology, .world:
                return Self.mainSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    static var errorScreen: UICollectionViewCompositionalLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            return Self.mainSection()
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private static func mainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4),
            heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
           
        return section
    }
    
    private static func supplementaryHeaderItem() ->  NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}
