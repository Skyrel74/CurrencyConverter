//
//  CoreDataManager.swift
//  Currency Converter
//
//  Created by Ilya on 15.12.2019.
//  Copyright © 2019 Ilya. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum CoreDataManager {
    
    static var shared = [NSManagedObject]()
    
    static func save(name: String, proportion: Double) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Money", in: managedContext)!
        
        let currency = NSManagedObject(entity: entity, insertInto: managedContext)
        
        currency.setValue(name, forKeyPath: "name")
        currency.setValue(proportion, forKey: "proportion")
        
        do {
            try managedContext.save()
            self.shared.append(currency)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func fetch() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Money")
        
        do {
            self.shared = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    static func clearData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Money")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
