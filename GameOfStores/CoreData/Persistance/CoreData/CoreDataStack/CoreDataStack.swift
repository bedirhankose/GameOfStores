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
    
    // MARK: - PersistentContainer
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - MoC
    lazy var managedContext: NSManagedObjectContext = {
        let context = storeContainer.viewContext
        return context
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        guard managedContext.hasChanges else {
            return
        }
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
