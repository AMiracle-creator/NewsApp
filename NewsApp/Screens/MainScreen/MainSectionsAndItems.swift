//
//  MainSectionsAndItems.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 19.04.2024.
//

import Foundation
import UIKit

// MARK: - Sections

enum Sections: Hashable {
    case business([Item])
    case entertainment([Item])
    case general([Item])
    case health([Item])
    case nation([Item])
    case science([Item])
    case sports([Item])
    case technology([Item])
    case world([Item])
}

// MARK: - Item

enum Item: Hashable {
    case general(Article)
    case loading(Int)
    case error(Int)
}

// MARK - Sections Extension

extension Sections {
    var items: [Item] {
        switch self {
        case .business(let items), .entertainment(let items), .general(let items), .health(let items),
                .nation(let items), .science(let items), .sports(let items), .technology(let items),  .world(let items):
            return items
        }
    }
}

extension Sections {
    
    static var businessLoading: Self = {
        .business([.loading(0), .loading(1), .loading(2), .loading(3), .loading(4), .loading(5)])
    }()
    
    static var entertainmentLoading: Self = {
        .entertainment([.loading(6), .loading(7), .loading(8), .loading(9), .loading(10), .loading(11)])
    }()
    
    static var generalLoading: Self = {
        .general([.loading(12), .loading(13), .loading(14), .loading(15), .loading(16), .loading(17)])
    }()
    
    static var sectionError: Self = {
        .business([.error(0)])
    }()
    
    static func dataSection(for index: Int) -> Self {
        switch index {
        case 0:
            return .business([])
        case 1:
            return .entertainment([])
        case 2:
            return .general([])
        case 3:
            return .health([])
        case 4:
            return .nation([])
        case 5:
            return .science([])
        case 6:
            return .sports([])
        case 7:
            return .technology([])
        case 8:
            return .world([])
        default:
            return .business([])
        }
    }
}

