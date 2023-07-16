//
//  Persistence.swift
//  Todo
//
//  Created by Jia Chen Yee on 03/07/23.
//

import CoreData
import CloudKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Todo(context: viewContext)
            newItem.creationDate = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Todo")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        let localStoreDescription = container.persistentStoreDescriptions.first!
        let storesURL = localStoreDescription.url!.deletingLastPathComponent()
        
        localStoreDescription.url = storesURL.appendingPathComponent("private.sqlite")
        
        // Create a store description for a CloudKit-backed local store
        let cloudStoreLocation = storesURL.appendingPathComponent("cloud.sqlite")
        let cloudStoreDescription =
            NSPersistentStoreDescription(url: cloudStoreLocation)
        cloudStoreDescription.configuration = "Cloud"

        cloudStoreDescription.cloudKitContainerOptions =
            NSPersistentCloudKitContainerOptions(
                containerIdentifier: "app.jiachen.sample.todo")
        
        container.persistentStoreDescriptions = [
            localStoreDescription,
            cloudStoreDescription
        ]
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        do {
            try container.viewContext.setQueryGenerationFrom(.current)
        } catch {
            fatalError("Failed to pin viewContext to the current generation: \(error)")
        }
    }
}
