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

    let name: String
    let sanskritName: String
    
    init?(dictionary: [String: AnyObject]) {
        guard let name = dictionary["name"] as? String, sanskritName = dictionary["sanskritName"] as? String else {return nil}
        
        self.name = name
        self.sanskritName = sanskritName
        
    }

}
