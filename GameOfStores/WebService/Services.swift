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
