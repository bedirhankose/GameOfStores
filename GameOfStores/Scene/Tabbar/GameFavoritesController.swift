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
    

    

}
