//
//  GameViewModel.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import Foundation

// MARK: - Protocol
protocol IGameViewModel {
    func fetchGames(completion: @escaping ([GameResult]?) -> Void)
    func getGameDetail(gameId: Int, completion: @escaping (GameDetailResults?) -> Void)
    var delegate: GameOutput? { get set }
}

// MARK: - ViewModel Class
final class GameViewModel: IGameViewModel {
    var delegate: GameOutput?
    private var service: ServiceProtocol
    init(service: ServiceProtocol) {
        self.service = service
    }
}

extension GameViewModel {
    func fetchGames(completion: @escaping ([GameResult]?) -> Void) {
        service.fetchGames { model in
            guard let model = model else { completion(nil); return }
            completion(model)
        }
    }
    
    func getGameDetail(gameId: Int, completion: @escaping (GameDetailResults?) -> Void) {
        service.getGameDetail(gameId: gameId) { model in
            guard let model = model else { completion(nil); return }
            completion(model)
        }
    }
}
