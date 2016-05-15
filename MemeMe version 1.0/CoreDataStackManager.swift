//
//  CoreDataStackManager.swift
//  MemeMe version 1.0
//
//  Created by Johnny Parham on 5/15/16.
//  Copyright © 2016 Johnny Parham. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStackManager {
    
    // MARK: -
    // MARK: Singletron instance
    
    class func sharedInstance() -> CoreDataStackManager {
    
        struct Static {
            static let sharedInstance = CoreDataStackManager()
        }
        
        return Static.sharedInstance
    }
    
    // MARK: -
    // MARK: Managed object context
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        // document directory to put the sqlite file
        let documentDirectory =
        NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last
        
        // model object
        let managedObjectModel = NSManagedObjectModel(contentsOfURL: NSBundle.mainBundle().URLForResource("MemeModel", withExtension: "momd")!)
        
        // persistant store coordinator
        let persistantStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel!)
        
        do {
            try persistantStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: documentDirectory?.URLByAppendingPathComponent("MemeStore.sqlite"), options: nil)
        } catch {
            NSLog("There was an error creating or loading the application's saved data.")
            
            abort()
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistantStoreCoordinator
        
        return managedObjectContext
    }()
    
    // MARK: -
    // MARK: Helper functions
    
    func saveContext() {
        
        if managedObjectContext.hasChanges {
            
            do {
                try managedObjectContext.save()
                
            } catch let error as NSError {
                print("Error to save meme! \(error)")
                
                abort()
            }
        }
    }
    
    
}
