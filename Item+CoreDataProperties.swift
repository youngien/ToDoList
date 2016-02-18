//
//  Item+CoreDataProperties.swift
//  ToDoList
//
//  Created by David Yu on 2/17/16.
//  Copyright © 2016 David Yu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var title: String?

}
