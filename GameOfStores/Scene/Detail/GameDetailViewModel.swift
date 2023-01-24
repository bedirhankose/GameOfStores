//
//  GameDetailViewModel.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import Foundation

enum GameDetailOutPut {
    case gameDetailList(GameDetailResults)
    case gameDetailError(String)
}

// MARK: - GameDetailDetailViewModel
protocol GameDetailViewDelegate {
    func handleOutPut(_ output: GameDetailOutPut)
}
