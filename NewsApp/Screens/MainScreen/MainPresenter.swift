//
//  MainPresenter.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 20.04.2024.
//

import Foundation
import UIKit

// MARK: - MainViewInputProtocol

protocol MainViewInput: AnyObject {
    func updateView(with sections: [Sections])
}

// MARK: - MainViewOutputProtocol

protocol MainViewOutput: AnyObject {
    func viewDidLoad()
    func viewDidSelectItem(_ item: Item)
    func filterContent(queryOrNil: String?)
}

// MARK: - MainViewPresenter

final class MainViewPresenter: MainViewOutput {
    weak var view: MainViewInput?
    let networkService: NetworkServiceProtocol
    var generalNewsCells = [Item]()
    var businessNewsCells = [Item]()
    var entertainmentNewsCells = [Item]()
    var healthNewsCells = [Item]()
    var nationNewsCells = [Item]()
    var scienceNewsCells = [Item]()
    var sportsNewsCells = [Item]()
    var technologyNewsCells = [Item]()
    var worldNewsCells = [Item]()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: MainViewOutput
    
    func viewDidLoad() {
        view?.updateView(with: [.businessLoading, .entertainmentLoading, .generalLoading])
        getNews()
    }
    
    func viewDidSelectItem(_ item: Item) {
        switch item {
        case .general(let article):
            print(article)
            guard let url = URL(string: article.url) else { return }

            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Unable to open url")
            }
        case .error, .loading:
            break
        }
    }
    
    func filterContent(queryOrNil: String?) {
        guard let query = queryOrNil, !query.isEmpty else {
            self.view?.updateView(with: [
                .business(self.businessNewsCells),
                .entertainment(self.entertainmentNewsCells),
                .general(self.generalNewsCells),
                .health(self.healthNewsCells),
                .science(self.scienceNewsCells),
                .sports(self.sportsNewsCells),
                .technology(self.technologyNewsCells)
            ])
            return
        }

        let filteredBusinessArticles = filterArticles(businessNewsCells, byQuery: query)
        let filteredEntertainmentArticles = filterArticles(entertainmentNewsCells, byQuery: query)
        let filteredGeneralArticles = filterArticles(generalNewsCells, byQuery: query)
        let filteredHealthArticles = filterArticles(healthNewsCells, byQuery: query)
        let filteredScienceArticles = filterArticles(scienceNewsCells, byQuery: query)
        let filteredSportsArticles = filterArticles(sportsNewsCells, byQuery: query)
        let filteredTechnologyArticles = filterArticles(technologyNewsCells, byQuery: query)
        
        var updatedSections: [Sections] = []

        if !filteredBusinessArticles.isEmpty {
            updatedSections.append(.business(filteredBusinessArticles))
        }
        if !filteredEntertainmentArticles.isEmpty {
            updatedSections.append(.entertainment(filteredEntertainmentArticles))
        }
        if !filteredGeneralArticles.isEmpty {
            updatedSections.append(.general(filteredGeneralArticles))
        }
        if !filteredHealthArticles.isEmpty {
            updatedSections.append(.health(filteredHealthArticles))
        }
        if !filteredScienceArticles.isEmpty {
            updatedSections.append(.science(filteredScienceArticles))
        }
        if !filteredSportsArticles.isEmpty {
            updatedSections.append(.sports(filteredSportsArticles))
        }
        if !filteredTechnologyArticles.isEmpty {
            updatedSections.append(.technology(filteredTechnologyArticles))
        }
        
        self.view?.updateView(with: updatedSections)
    }
    
    // MARK: Private methods
    
    private func getNews() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        networkService.getNews(for: .business) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.businessNewsCells = articles.map { Item.general($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkService.getNews(for: .entertainment) { [weak self] result in
            guard let self = self else { return }
                    
            switch result {
            case .success(let articles):
                self.entertainmentNewsCells = articles.map { Item.general($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkService.getNews(for: .general) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.generalNewsCells = articles.map { Item.general($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        networkService.getNews(for: .health) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let articles):
                self.healthNewsCells = articles.map { Item.general($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        networkService.getNews(for: .science) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.scienceNewsCells = articles.map { Item.general($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        networkService.getNews(for: .sports) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let articles):
                self.sportsNewsCells = articles.map { Item.general($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }

        dispatchGroup.enter()
        networkService.getNews(for: .technology) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let articles):
                self.technologyNewsCells = articles.map { Item.general($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            
            self.view?.updateView(with: [
                .business(self.businessNewsCells),
                .entertainment(self.entertainmentNewsCells),
                .general(self.generalNewsCells),
                .health(self.healthNewsCells),
                .science(self.scienceNewsCells),
                .sports(self.sportsNewsCells),
                .technology(self.technologyNewsCells),
            ])
        }
    }
    
    private func filterArticles(_ articles: [Item], byQuery query: String) -> [Item] {
        let filteredArticles = articles.compactMap { item -> Article? in
            if case .general(let article) = item {
                return article
            }
            return nil
        }.filter { article in
            return article.title.lowercased().contains(query.lowercased())
        }.map { article in
            return Item.general(article)
        }

        return filteredArticles
    }
}

