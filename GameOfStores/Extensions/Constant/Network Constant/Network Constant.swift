//
//  Network Constant.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
// "https://api.rawg.io/api/games?key=a3c44eeeab454875b62ce01dbf979873"

import Foundation

extension Constant {
    class NetworkConstant{
        enum GameServiceEndPoint: String {
            case BASE_URL = "https://api.rawg.io/api/games"
            case API_KEY = "a3c44eeeab454875b62ce01dbf979873"
            
            static func fetchGame() -> String {
                "\(BASE_URL.rawValue)?key=\(API_KEY.rawValue)"
            }
            
            static func detailGame(gameId: Int) -> String {
                "\(BASE_URL.rawValue)/\(gameId)?key=\(API_KEY.rawValue)"
            }
        }
    }
}
