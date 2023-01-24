//
//  GameDetailController.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import UIKit

class GameDetailController: UIViewController {
    
    // MARK: - Properties
    private var gameDetailResults: GameDetailResults
    var gameID: Int?
    var errorMessage = String()
    
    // MARK: - UI Elements
    private let imageView : UIImageView = {
        let detailImageView = UIImageView()
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        detailImageView.contentMode = .scaleToFill
        detailImageView.layer.cornerRadius = 15
        detailImageView.clipsToBounds = true
        detailImageView.layer.borderColor = UIColor.black.cgColor
        detailImageView.layer.borderWidth = 2
        return detailImageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let metacriticLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .systemGray
        return label
    }()
    
    private let releasedLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .right
        label.textColor = .systemGray
        return label
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.isSelectable = false
        textView.isEditable = false
        textView.textAlignment = .left
        textView.font = .boldSystemFont(ofSize: 20)
        return textView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 32
        return stackView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .red
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.contentHorizontalAlignment = .right
        button.contentVerticalAlignment = .top
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 48), forImageIn: .normal)
        return button
    }()
    
    init(gameDetailResults: GameDetailResults) {
        self.gameDetailResults = gameDetailResults
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        favoriteButton.addTarget(self, action: #selector(favoriteList(_:)), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CoreDataManager.shared.checkIsFavourite(with: gameDetailResults.name) { result in
            switch result {
            case .success(let bool):
                bool ? self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
}
