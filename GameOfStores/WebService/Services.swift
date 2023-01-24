//
//  Services.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import Foundation
import Alamofire

// MARK: - Service Protocol
protocol ServiceProtocol {
    func fetchGames(completion: @escaping ([GameResult]?) -> Void)
    func getGameDetail(gameId: Int, completion: @escaping (GameDetailResults?) -> Void)
}

// MARK: - Services
final class Services: ServiceProtocol {
    
    func fetchGames(completion: @escaping ([GameResult]?) -> Void) {
        AF.request(Constant.NetworkConstant.GameServiceEndPoint.fetchGame()).responseDecodable(of: GameListModel.self) { data in
            guard let data = data.value else {
                completion(nil)
                return
            }
            completion(data.results)
        }
    }
    
    func getGameDetail(gameId: Int, completion: @escaping (GameDetailResults?) -> Void) {
        AF.request(Constant.NetworkConstant.GameServiceEndPoint.detailGame(gameId: gameId)).responseDecodable(of: GameDetailResults.self) { data in
            guard let data = data.value else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
