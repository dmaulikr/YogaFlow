//
//  Pose.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/18/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit
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
            typeArray = dictionary["Type"] as? [AnyObject]
            else { fatalError("Could not initialize Pose") }
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.name = name
        self.sanskritName = dictionary["Sanskrit Name"] as? String ?? nil
        self.flow = flow
        
        let types = typeArray.flatMap { Type(name: $0 as? String ?? "") }
        self.types = NSOrderedSet(array: types)
    }
    
    var image: UIImage {
        return UIImage(named: name) ?? UIImage()
    }
}
