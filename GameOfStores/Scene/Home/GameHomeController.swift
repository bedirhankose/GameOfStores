//
//  ViewController.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import UIKit
import SnapKit
import Kingfisher

// MARK: - ViewModel Output Protocol
protocol GameOutput {
    func selectedGame(gameId: Int)
}

final class GameHomeController: UIViewController, GameOutput{
    
    func selectedGame(gameId: Int) {
        viewModel.getGameDetail(gameId: gameId) { model in
            guard let model = model else {
                return
            }
            self.navigationController?.pushViewController(GameDetailController(gameDetailResults: model), animated: true)
        }
    }
    
    private var viewModel: IGameViewModel = GameViewModel(service: Services())
    private var searchData: [GameResult] = []
    private var isSearch = Bool()
    
// MARK: - UI ELEMENTS
    private let searchController: UISearchController = {
        let search = UISearchController()
        return search
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.contentMode = .scaleAspectFit
        scroll.backgroundColor = .black
        scroll.layer.cornerRadius = 15
        scroll.clipsToBounds = true
        scroll.contentSize = CGSize(width: view.frame.width * 3.6 , height: 0)
        return scroll
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private lazy var pageController: UIPageControl = {
        let page = UIPageControl()
        page.numberOfPages = 3
        page.currentPage = 0
        page.translatesAutoresizingMaskIntoConstraints = false
        page.pageIndicatorTintColor = UIColor.black
        page.currentPageIndicatorTintColor = UIColor.systemRed
        return page
    }()
    private lazy var errorLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.text = Constant.GameListError.errorLabel.rawValue
        label.isHidden = true
        return label
    }()
    
// MARK: - Scroll UIElements
    private lazy var image0 = UIImageView()
    private lazy var image1 = UIImageView()
    private lazy var image2 = UIImageView()
    private lazy var scrollImage: [UIImageView] = [image0, image1, image2]
    
// MARK: - Helpers
    private lazy var gameData: [GameResult] = []
    private lazy var error = String()
    
// MARK: - SearchControl
    private func isSearch(to search: Bool) {
        self.isSearch  = search
    }
    
    private func searchData(to data: [GameResult]) {
        self.searchData = data
    }
    
// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Home"
    }
    
// MARK: - Functions
    private func configure() {
        addSubview()
        drawDesign()
        makePageController()
        makeScrollView()
        remakeCollection()
        makeLabel()
        viewModelConnect()
    }
    
    private func viewModelConnect(){
        viewModel.delegate = self
        viewModel.fetchGames { [weak self] model in
            var collectionViewData = model
            for i in 0...4 {
                collectionViewData?.remove(at: i)
            }
            self?.gameData = collectionViewData ?? []
            self?.scrollImage(gameResult: model ?? [])
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func addSubview() {
        view.addSubview(pageController)
        view.addSubview(errorLabel)
        view.addSubview(collectionView)
        view.addSubview(scrollView)
    }
    
    private func drawDesign() {
        view.backgroundColor = .white
        searchController.searchBar.placeholder =  "Search Games"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.sizeToFit()
        collectionView.register(GameCollectionViewCell.self, forCellWithReuseIdentifier: GameCollectionViewCell.Identifier.path.rawValue)
        scrollView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

