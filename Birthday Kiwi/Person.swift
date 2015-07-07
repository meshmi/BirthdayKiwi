//
//  Person.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 22/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import Foundation
import CoreData

@objc(Person) class Person: NSManagedObject {

    // MARK: - NSManaged Properties
    
    @NSManaged var bday_day: NSNumber
    @NSManaged var bday_month: NSNumber
    @NSManaged var bday_year: NSNumber
    @NSManaged var name: String
    
    // MARK: - Initializers
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(name: String, bday_day: Int, bday_month: Int, bday_year: Int, context: NSManagedObjectContext) {
        // Access Core Data entity
        let entity = NSEntityDescription.entityForName(Client.Model_Entities.PERSON, inManagedObjectContext: context)!
        super.init(entity: entity, insertIntoManagedObjectContext: context)
        
        // Dictionary
        self.name = name
        self.bday_day = bday_day
        self.bday_month = bday_month
        self.bday_year = bday_year
    }
}
