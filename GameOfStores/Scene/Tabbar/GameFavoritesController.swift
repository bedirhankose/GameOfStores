//
//  GameFavoritesController.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import UIKit
import SnapKit

class GameFavoritesController: UIViewController {
    
    var favoritedGames: [Game] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - UIElements
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CoreDataManager.shared.getGamesFromPersistance { result in
            switch result {
            case .success(let games):
                self.favoritedGames = games
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: - Functions
    private func configure() {
        addSubviews()
        drawDesign()
        makeCollectionView()
    }
    
    private func drawDesign() {
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.Identifier.path.rawValue)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
}

extension GameFavoritesController {
    private func makeCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
        }
    }
}
