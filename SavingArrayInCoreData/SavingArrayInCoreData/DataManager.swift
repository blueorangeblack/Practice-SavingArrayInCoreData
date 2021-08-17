//
//  DataManager.swift
//  SavingArrayInCoreData
//
//  Created by Minju Lee on 2021/08/16.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let shared = DataManager()

    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var postList = [Post]()
    
    func fetchPost() {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        do {
            postList = try mainContext.fetch(request)
            print("패치")
        } catch {
            print(error)
        }
    }
    
    func addPost(aromas: [String], place: String, images: [UIImage]) {
        let object = NSEntityDescription.insertNewObject(forEntityName: "Post", into: mainContext)
        object.setValue(aromas, forKey: "aromas")
        object.setValue(place, forKey: "place")
        object.setValue(images, forKey: "images")
        saveContext()
        print("저장")
    }
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SavingArrayInCoreData")
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

    func saveContext () {
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
}
