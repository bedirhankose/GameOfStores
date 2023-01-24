//
//  CoreDataManager.swift
//  GameOfStores
//
//  Created by Bedirhan Köse on 24.01.23.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    var coreDataStack: CoreDataStack
    
    var moc: NSManagedObjectContext {
        return coreDataStack.managedContext
    }
    
    private init(coreDataStack: CoreDataStack = CoreDataStack(modelName: "GameOfStores")) {
        self.coreDataStack = coreDataStack
    }
    
    private func getRequest() -> NSFetchRequest<Game> {
        let request:NSFetchRequest<Game> = Game.fetchRequest()
        request.returnsObjectsAsFaults = false
        return request
    }
    
    private func uniqueGameNamePredicate(of request: NSFetchRequest<Game>, with uniqueName: String) -> NSPredicate {
        request.predicate =
            NSPredicate(format: "name == %@", uniqueName)
        return request.predicate!
    }
    
    func getGamesFromPersistance(completion: @escaping (Result<[Game], Error>) -> Void){
        do {
            let request = getRequest()
            let games = try moc.fetch(request)
            completion(.success(games))
        } catch {
            completion(.failure(error))
        }

    }
}
