//
//  PublicationCollectionViewCells.swift
//  NewsApp
//
//  Created by Амир Гайнуллин on 20.04.2024.
//

import UIKit
import SnapKit
import Kingfisher

class ArticlesCollectionViewCell: UICollectionViewCell {
    // MARK: Properties
    
    static let reuseIdentifier = "ArticlesCollectionViewCell"

    // MARK: UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.7).cgColor]
        layer.locations = [0.0, 1.0]
        return layer
    }()
    
    // MARK: LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
            
        imageView.image = nil
        textLabel.text = nil
    }
    
    // MARK: UI Setup
    
    private func setupUI() {
        self.addSubview(imageView)
        self.addSubview(textLabel)
        imageView.layer.addSublayer(gradientLayer)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.greaterThanOrEqualToSuperview().offset(10)
            $0.height.lessThanOrEqualToSuperview().offset(-20)
        }
        
        gradientLayer.frame = contentView.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
    }
    
    // MARK: Cell configuration
    
    func configure(imageURL: String, text: String) {
        let url = URL(string: imageURL)
        imageView.kf.setImage(with: url, placeholder: UIImage(systemName: "globe"))
        textLabel.text = text
    }
}
