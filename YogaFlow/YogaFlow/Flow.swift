//
//  Flow.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/18/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData


class Flow: NSManagedObject {
    
    convenience init(name: String, notes: String?, poses: [Pose], timestamp: NSDate = NSDate(), context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("Flow", inManagedObjectContext: context) else { fatalError("Could not initialize Pose") }
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.poses = NSOrderedSet(array: poses)
        self.name = name
        self.notes = notes
        self.timestamp = timestamp
    }
    
}
