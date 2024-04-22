//
//  HeaderSupplementaryView.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 20.04.2024.
//

import Foundation
import UIKit
import SnapKit

class HeaderSupplementaryView: UICollectionReusableView {
    // MARK: Properties
    
    static let reuseIdentifier = "HeaderSupplementaryView"
    
    // MARK: UI Components
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Setup
    
    private func setupUI() {
        self.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
    
    // MARK: Configuration
    
    func configure(text: String) {
        headerLabel.text = text
    }
}
