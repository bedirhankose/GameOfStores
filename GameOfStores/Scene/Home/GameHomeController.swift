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
    
    
}

