//
//  Message+CoreDataProperties.swift
//  SlapChat
//
//  Created by Ismael Barry on 7/24/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

// This was made so that Core Data can manage our object's properties.
extension Message {

    @NSManaged var content: String?
    @NSManaged var createdAt: NSDate?
    @NSManaged var recipient: String? // Never used the recipient variable.
    @NSManaged var recipients: Recipient?

}
