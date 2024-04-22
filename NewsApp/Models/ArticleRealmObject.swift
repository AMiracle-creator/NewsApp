//
//  ArticleRealmObject.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 21.04.2024.
//

import Foundation
import RealmSwift

// MARK: - ArticleRealmObject

final class ArticleRealmObject: Object {
    @Persisted(primaryKey: true) var uuid: String
    @Persisted var author: String?
    @Persisted var title: String = ""
    @Persisted var articleDescription: String?
    @Persisted var url: String = ""
    @Persisted var urlToImage: String?
    @Persisted var publishedAt: String = ""
    @Persisted var content: String?

    convenience init(from article: Article) {
        self.init()
        author = article.author
        title = article.title
        articleDescription = article.description
        url = article.url
        urlToImage = article.urlToImage
        publishedAt = article.publishedAt
        content = article.content
    }
}

extension ArticleRealmObject {
    func toArticle() -> Article {
        return Article(
            author: author,
            title: title,
            description: articleDescription,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content
        )
    }
}
