//
//  CoreDataStack.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import Foundation
import CoreData
final class CoreDataStack {
    
    // MARK: - Properties
    
    private let modelName: String
    
    // MARK: - Init
    
    init(modelName: String) {
        self.modelName = modelName
    }
}
