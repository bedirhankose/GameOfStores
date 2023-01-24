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
    
    
    
}

