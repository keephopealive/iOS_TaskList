//
//  Task+CoreDataProperties.swift
//  TaskList
//
//  Created by Speros Misirlakis on 2/19/16.
//  Copyright © 2016 Speros Misirlakis. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var title: String?
    @NSManaged var dueDate: NSDate?
    @NSManaged var details: String?

}
