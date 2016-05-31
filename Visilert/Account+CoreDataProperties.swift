//
//  Account+CoreDataProperties.swift
//  Visilert
//
//  Created by Rene Candelier on 2/28/16.
//  Copyright © 2016 CCE. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Account {

    @NSManaged var username: String?
    @NSManaged var password: String?
    @NSManaged var name: String?
    @NSManaged var lastname: String?
    @NSManaged var email: String?
    @NSManaged var training: String?

}
