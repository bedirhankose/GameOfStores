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
    
// MARK: - Snapkit Constraints
    private func makePageController() {
        pageController.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.32)
            make.height.equalTo(20)
        }
    }
    private func makeScrollView() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.32)
        }
    }
    
    private func makeCollection() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(scrollView)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func makeLabel() {
        errorLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
    private func remakeCollection() {
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(pageController.snp.bottom).offset(10)
            make.left.right.equalTo(scrollView)
            make.bottom.equalToSuperview().inset(20)
        }
    }

}

// MARK: - Search Result Functions
extension GameHomeController: UISearchResultsUpdating {
    
    private func searchAnimation() {
        if searchController.isActive {
            searchController.searchBar.showsCancelButton = true
            scrollView.isHidden = true
            pageController.isHidden = true
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().inset(10)
                make.bottom.equalToSuperview().inset(20)
            }
            collectionView.frame.size.width = view.frame.width
            collectionView.frame.size.height = view.frame.height / 2.1
            
        } else {
            scrollView.isHidden = false
            pageController.isHidden = false
            searchController.searchBar.showsCancelButton = false
            remakeCollection()
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        searchData = gameData.filter({ (result:GameResult) -> Bool in
            let nameMatch = result.name.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return nameMatch != nil
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        searchAnimation()
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            collectionView.reloadData()
        }
    }
}
