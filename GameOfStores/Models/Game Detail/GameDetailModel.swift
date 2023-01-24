//
//  GameDetailModel.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import Foundation

// MARK: - GameDetailResults
struct GameDetailResults: Codable {
    let name, gameResultsDescription: String
    let metacritic: Int
    let released: String
    let backgroundImage: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case gameResultsDescription = "description"
        case metacritic
        case released
        case backgroundImage = "background_image"
        case id
    }
}
