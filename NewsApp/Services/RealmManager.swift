//
//  RealmManager.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 22.04.2024.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()

    private init() {}

    private let realm = try! Realm()

    func saveArticles(_ articles: [Article]) {
        try! realm.write {
            for article in articles {
                realm.add(ArticleRealmObject(from: article), update: .all)
            }
        }
    }

    func getArticles() -> [Article] {
        let articleObjects = realm.objects(ArticleRealmObject.self)
        var articles: [Article] = []
        for articleObject in articleObjects {
            let article = articleObject.toArticle()
            articles.append(article)
        }
        return articles
    }
}
