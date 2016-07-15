//
//  Pose.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/15/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData


class Pose: NSManagedObject {

    convenience init?(dictionary: [String: AnyObject], context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("Pose", inManagedObjectContext: context) else {return nil}
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        
    }

}
