//
//  CoreDataManager.swift
//  EyesApp
//
//  Created by Visha Shanghvi on 2019-07-22.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import CoreData

/// Core Data stack
final class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    private static let entityName = "User"
    private static let contentEntity = "Content"
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "EyesApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchUsers() -> [User]? {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<User>(entityName: CoreDataManager.entityName)
        let sortDescriptor1 = NSSortDescriptor(key: "userName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1]
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func fetchUserContent(forUser id: Int64) -> [Content]? {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Content>(entityName: CoreDataManager.contentEntity)
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        do {
            let usersDetail = try managedObjectContext.fetch(fetchRequest)
            return usersDetail
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func clearStorage() {
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }
        
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataManager.entityName)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let users = try managedObjectContext.fetch(fetchRequest)
                for user in users {
                    managedObjectContext.delete(user as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }

}
