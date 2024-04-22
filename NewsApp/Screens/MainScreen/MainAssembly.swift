//
//  MainAssembly.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 20.04.2024.
//

import Foundation
import UIKit

// MARK: - MainAssemblyProtocol

protocol MainAssemblyProtocol {
    func assemble() -> UIViewController
}

// MARK: - MainAssembly

final class MainAssembly: MainAssemblyProtocol {
    func assemble() -> UIViewController {
        let networkService = NetworkService()
        let presenter = MainViewPresenter(networkService: networkService)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
