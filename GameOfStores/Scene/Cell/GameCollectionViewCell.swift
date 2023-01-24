//
//  GameCollectionViewCell.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import UIKit

final class GameCollectionViewCell: UICollectionViewCell {
    
// MARK: - GameHomeController - UI Elements
    private lazy var gameImageView: UIImageView = {
        let gameImage = UIImageView()
        gameImage.clipsToBounds = true
        gameImage.translatesAutoresizingMaskIntoConstraints = false
        gameImage.layer.cornerRadius = 12
        contentView.addSubview(gameImage)
        return gameImage
    }()
    
    private lazy var gameMetacriticLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        addSubview(label)
        return label
    }()
    
    private lazy var gameReleasedLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        addSubview(label)
        return label
    }()
    
    private lazy var gameNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .systemIndigo
        label.numberOfLines = 0
        addSubview(label)
        return label
    }()
    
    enum Identifier: String {
        case path = "Cell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        makeImage()
        makeName()
        makeReleased()
        makeMetacritic()
    }
}
}
