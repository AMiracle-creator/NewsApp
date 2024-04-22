//
//  NetworkService.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 19.04.2024.
//

import Foundation
import Alamofire

// MARK: - News Categories

enum NewsCategory: String {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
}

// MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol {
    func getNews(for category: NewsCategory, completion: @escaping (Result<[Article], Error>) -> Void)
}

// MARK: - NetworkService

final class NetworkService: NetworkServiceProtocol {
    
    private let baseURL = "https://newsapi.org/v2/top-headlines"
    private let apiKey = "f30ea6045322470eacf1dca2b9e3c18c"
    
    func getNews(for category: NewsCategory, completion: @escaping (Result<[Article], Error>) -> Void) {
        let parameters: [String: Any] = [
            "country": "us",
            "category": category.rawValue,
            "apiKey": apiKey
        ]
            
        AF.request(baseURL, parameters: parameters).validate().responseDecodable(of: News.self) { response in
            switch response.result {
            case .success(let newsResponse):
//                RealmManager.shared.saveArticles(newsResponse.articles)
                completion(.success(newsResponse.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
