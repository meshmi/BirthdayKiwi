//
//  Database.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 25/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit
import CoreData

class Database: NSObject {
    
    // MARK: - Properties
    
    // Managed Object Context singleton
    static let sharedContext = CoreDataStackManager.sharedInstance().managedObjectContext
    
    // MARK: - Custom Methods
    
    class func checkDatabaseForName(name: String) -> Bool {
        let fetchRequest = NSFetchRequest(entityName: Client.Model_Entities.PERSON)
        
        let predicate = NSPredicate(format: "\(Client.Model_Attributes.NAME) == %@", name)
        
        fetchRequest.predicate = predicate
        
        var fetchingError: NSError?
        
        let fetchResults = self.sharedContext?.executeFetchRequest(fetchRequest, error: &fetchingError) as? [Person]
        
        if fetchResults?.count > 0 {
            return true
        } else {
            return false
        }
    }
}
