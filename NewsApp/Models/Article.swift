//
//  Article.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 19.04.2024.
//

import Foundation

// MARK: - News
//struct News: Decodable {
//    let totalArticles: Int
//    let articles: [Article]
//}
//
//// MARK: - Article
//struct Article: Decodable, Hashable {
//    let title: String
//    let description: String
//    let content: String
//    let url: String
//    let image: String
//    let publishedAt: String
//}
//
//// MARK: - Source
//struct Source: Decodable {
//    let name: String
//    let url: String
//}


// MARK: - News
struct News: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Decodable {
    let uuid = UUID()
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

extension Article : Hashable {
    static func ==(lhs: Article, rhs: Article) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
