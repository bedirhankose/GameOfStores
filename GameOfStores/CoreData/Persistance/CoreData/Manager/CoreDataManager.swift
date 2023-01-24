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
    
    func checkIsFavourite(with uniqueGameName: String, completion: @escaping (Result<Bool, Error>) -> Void){
        
        do {
            let request = getRequest()
            request.predicate = uniqueGameNamePredicate(of: request, with: uniqueGameName)
            let fetchedResults = try moc.fetch(request)
            fetchedResults.first != nil ? completion(.success(true)) : completion(.success(false))
        } catch {
            completion(.failure(error))
        }
    }
    
    func createGame(with gameResult: GameDetailResults) {
        let game = Game(context: moc)
        game.name = gameResult.name
        game.metacritic = String(gameResult.metacritic)
        game.backgroundImage = gameResult.backgroundImage
        game.released = gameResult.released
        coreDataStack.saveContext()
    }
    
    func deleteGame(with uniqueName: String, completion: @escaping (Error) -> Void) {
        let request = getRequest()
        request.predicate = uniqueGameNamePredicate(of: request, with: uniqueName)
        do {
            let fetchedResult = try moc.fetch(request)
            if let gameModel = fetchedResult.first {
                print("debug: deleting game model which is \(gameModel)")
                moc.delete(gameModel)
                coreDataStack.saveContext()
            }
        } catch {
            completion(error)
        }
    }
}
