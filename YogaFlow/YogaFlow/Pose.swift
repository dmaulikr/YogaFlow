//
//  Pose.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/18/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData


class Pose: NSManagedObject {
    
        convenience init(name: String, sanskritName: String?, types: [Type], context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
            guard let entity = NSEntityDescription.entityForName("Pose", inManagedObjectContext: context) else {
                fatalError("Could not initialize Pose")
            }
            self.init(entity: entity, insertIntoManagedObjectContext: context)
    
            self.name = name
            self.sanskritName = sanskritName
            self.types = NSOrderedSet(array: types)
            self.flow = nil
        }
    
    convenience init(name: String, dictionary: [String: AnyObject], flow: Flow? = nil, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("Pose", inManagedObjectContext: context),
            typeArray = dictionary["type"] as? [String]
            else { fatalError("Could not initialize Pose") }
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.sanskritName = dictionary["sanskrit_name"] as? String ?? nil
        self.flow = flow
        
        let types = typeArray.flatMap { Type(name: $0) }
        self.types = NSOrderedSet(array: types)
    }
}

/* 
 "big_toe_pose": {
    "sanskrit_name": "Padangusthasana",
    "type": [
        "forward bend",
        "standing"
    ]
 }
 */
