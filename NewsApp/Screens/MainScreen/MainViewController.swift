//
//  ViewController.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 19.04.2024.
//

import UIKit
import SnapKit
import Kingfisher

private typealias DataSource = UICollectionViewDiffableDataSource<Sections, Item>

class MainViewController: UIViewController {
    // MARK: Properties
    
    private let presenter: MainViewOutput
    
    private lazy var dataSource: DataSource = {
        let dataSource = configureDataSource()
        let initialSnapshot = dataSource.snapshot()
        return dataSource
    }()
    
    // MARK: UI Components
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .mainScreen)
        collectionView.register(ArticlesCollectionViewCell.self, forCellWithReuseIdentifier: ArticlesCollectionViewCell.reuseIdentifier)
        collectionView.register(HeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSupplementaryView.reuseIdentifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: LifeCycle
    
    init(presenter: MainViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupUI()
        self.configureHeaders()
        self.presenter.viewDidLoad()
        
        title = "News"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: UI Setup
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: SearchController Setup
    
    private func setupSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search news"
        self.searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: Configuring DataSource
    
    private func configureDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .general(let article):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticlesCollectionViewCell.reuseIdentifier, for: indexPath) as? ArticlesCollectionViewCell else { fatalError("Cannot create the cell") }
                
                let image = article.urlToImage ?? ""
                cell.configure(imageURL: image, text: article.title)
                return cell
                
            case .loading:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
                cell.backgroundColor = .systemGray
                cell.layer.cornerRadius = 16
                return cell
                
            case .error:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
                cell.backgroundColor = .red
                cell.layer.cornerRadius = 16
                return cell
            }
        }
    }
    
    // MARK: Configuring headers
    
    private func configureHeaders() {
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSupplementaryView.reuseIdentifier, for: indexPath) as! HeaderSupplementaryView
                
                let section = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
                           
                switch section {
                case .business:
                    header.configure(text: "Business")
                case .entertainment:
                    header.configure(text: "Entertainment")
                case .general:
                    header.configure(text: "General")
                case .health:
                    header.configure(text: "Health")
                case .nation:
                    header.configure(text: "Nation")
                case .science:
                    header.configure(text: "Science")
                case .sports:
                    header.configure(text: "Sports")
                case .technology:
                    header.configure(text: "Technology")
                case .world:
                    header.configure(text: "World")
                }
                
                return header
                
            default:
                return nil
            }
        }
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func updateView(with sections: [Sections]) {
        var snapshot = NSDiffableDataSourceSnapshot<Sections, Item>()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }

        presenter.viewDidSelectItem(item)
    }
}

// MARK: - UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       presenter.filterContent(queryOrNil: searchController.searchBar.text)
    }
}

