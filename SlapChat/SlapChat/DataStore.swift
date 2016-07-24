//
//  DataStore.swift
//  SlapChat
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    
    // Create a public Array property to hold your fetched message objects:
    var messages:[Message] = []
    
    // Create a public Array property to hold your fetched recipient objects:
    var recipients:[Recipient] = []
    
    // Because this is a "static let" we call this specific variable without having to instatiate a version or actual instance of DataStore. When we call DataStore.sharedDataStore(), we create one single instance of data store. Thus, anywhere in our code, we can all any functions from DataStore and be working within the same exact object context.
    static let sharedDataStore = DataStore()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            // What we what to happen:
            do {
                try managedObjectContext.save()
            // What happens when we fail:
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    // Implement fetchData() to create an NSFetchRequest, have your context execute it, and set the results to your messages array:
    func fetchData () {
        
        var error:NSError? = nil
        
        let messagesRequest = NSFetchRequest(entityName: Message.messageEntityName) // entity name corresponds to the entity name we created in our data model.
        
        let createdAtSorter = NSSortDescriptor(key: "createdAt", ascending:true) // create a sort descriptor to sort by date
        
        messagesRequest.sortDescriptors = [createdAtSorter]
        
        // What we want to happen:
        do {
            //perform a fetch request to fill our array property on your datastore:
            self.messages = try managedObjectContext.executeFetchRequest(messagesRequest) as! [Message]
        
        // What happens when we fail:
        } catch {

            print("Fetching Messages does not work.")
            
        }
        
        // If your messages array is still empty, call generateTestData() and pass them again.
        if messages.count == 0 {
            generateTestData()
        }
    }
    
    // Implement fetchData() to create an NSFetchRequest, have your context execute it, and set the results to your recipient array:
    func fetchRecipients()  {
        
        var error : NSError? = nil
        
        let recipientRequest = NSFetchRequest(entityName: Recipient.recipientEntityName) // entity name corresponds to the entity name we created in our data model.
        
        let nameSorter = NSSortDescriptor(key: "name", ascending: true) // create a sort descriptor to sort by name.
        
        recipientRequest.sortDescriptors = [nameSorter]
        
        // What we want to happen:
        do {
            
            //perform a fetch request to fill our array property on your datastore:
            self.recipients = try managedObjectContext.executeFetchRequest(recipientRequest) as! [Recipient]
        
        // What happens when we fail:
        } catch {
            
           print("Fetching Recipients does not work.")
            
        }
        
        // If your recipient array is still empty, call generateTestData() and pass them again.
        if recipients.count == 0 {
            generateTestData()
        }
        
    }
    
    // Create a few Messages and recipients. Use NSEntityDescription class function insertNewObjectForEntityForName(_:inManagedObjectContext:)
    // Don't forget to set your test messages' content and createdAt properties!
    // Don't forget to set your recipient's name, email, phoneNumber, twitterHandle, and messages!
    func generateTestData() {
        
        let messageOne: Message = NSEntityDescription.insertNewObjectForEntityForName(Message.messageEntityName, inManagedObjectContext: managedObjectContext) as! Message // cast to a Message Type because it is originally an NSManagedObject.
        messageOne.content = "This is Ismael's message."
        messageOne.createdAt = NSDate()
        
        let messageTwo: Message = NSEntityDescription.insertNewObjectForEntityForName(Message.messageEntityName, inManagedObjectContext: managedObjectContext) as! Message // cast to a Message Type because it is originally an NSManagedObject.
        messageTwo.content = "This is Tidiane's message."
        messageTwo.createdAt = NSDate()
        
        let messageThree: Message = NSEntityDescription.insertNewObjectForEntityForName(Message.messageEntityName, inManagedObjectContext: managedObjectContext) as! Message // cast to a Message Type because it is originally an NSManagedObject.
        messageThree.content = "This is Sonia's message."
        messageThree.createdAt = NSDate()
        
        let ismaelMessage: Message = NSEntityDescription.insertNewObjectForEntityForName(Message.messageEntityName, inManagedObjectContext: managedObjectContext) as! Message // cast to a Message Type because it is originally an NSManagedObject.
        ismaelMessage.content = "A custom message for Ismael to show the one to many relationship."
        ismaelMessage.createdAt = NSDate()
        
        let tidianeMessage: Message = NSEntityDescription.insertNewObjectForEntityForName(Message.messageEntityName, inManagedObjectContext: managedObjectContext) as! Message // cast to a Message Type because it is originally an NSManagedObject.
        tidianeMessage.content = "A custom message for Tidiane to show the one to many relationship."
        tidianeMessage.createdAt = NSDate()
        
        let soniaMessage: Message = NSEntityDescription.insertNewObjectForEntityForName(Message.messageEntityName, inManagedObjectContext: managedObjectContext) as! Message // cast to a Message Type because it is originally an NSManagedObject.
        soniaMessage.content = "A custom message for Sonia to show the one to many relationship."
        soniaMessage.createdAt = NSDate()
        
        let recipientOne: Recipient = NSEntityDescription.insertNewObjectForEntityForName(Recipient.recipientEntityName, inManagedObjectContext: managedObjectContext) as! Recipient // cast to a Recipient Type because it is originally an NSManagedObject.
        recipientOne.name = "Ismael"
        recipientOne.email = "ismael@gmail.com"
        recipientOne.phoneNumber = "123-456-7890"
        recipientOne.twitterHandle = "@ismael"
        recipientOne.messages?.insert(messageOne) // Creating a relationship between recipientOne and messageOne.
        recipientOne.messages?.insert(ismaelMessage) // Creating a relationship between recipientOne and ismaelMessage.
        
        let recipientTwo: Recipient = NSEntityDescription.insertNewObjectForEntityForName(Recipient.recipientEntityName, inManagedObjectContext: managedObjectContext) as! Recipient // cast to a Recipient Type because it is originally an NSManagedObject.
        recipientTwo.name = "Tidiane"
        recipientTwo.email = "tidiane@gmail.com"
        recipientTwo.phoneNumber = "098-765-4321"
        recipientTwo.twitterHandle = "@tidiane"
        recipientTwo.messages?.insert(messageTwo) // Creating a relationship between recipientTwo and messageTwo.
        recipientTwo.messages?.insert(tidianeMessage) // Creating a relationship between recipientOne and tidianeMessage.
        
        let recipientThree: Recipient = NSEntityDescription.insertNewObjectForEntityForName(Recipient.recipientEntityName, inManagedObjectContext: managedObjectContext) as! Recipient // cast to a Recipient Type because it is originally an NSManagedObject.
        recipientThree.name = "Sonia"
        recipientThree.email = "sonia@gmail.com"
        recipientThree.phoneNumber = "246-135-7980"
        recipientThree.twitterHandle = "@sonia"
        recipientThree.messages?.insert(messageThree) // Creating a relationship between recipientThree and messageThree.
        recipientThree.messages?.insert(soniaMessage) // Creating a relationship between recipientOne and soniaMessage.

        saveContext()
        fetchRecipients()
    }
    
    // MARK: - Core Data stack
    // Managed Object Context property getter. This is where we've dropped our "boilerplate" code.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("SlapChat", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    //MARK: Application's Documents directory
    // Returns the URL to the application's Documents directory.
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.FlatironSchool.SlapChat" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
}