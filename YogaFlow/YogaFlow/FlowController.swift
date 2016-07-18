//
//  FlowController.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/15/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import Foundation
import CoreData

class FlowController {
    
    static let sharedController = FlowController()
    
    var flows: [Flow] {
        let request = NSFetchRequest(entityName: "Flow")
        let moc = Stack.sharedStack.managedObjectContext
        return (try? moc.executeFetchRequest(request)) as? [Flow] ?? []
    }
    
    func createFlow(name: String, notes: String?, poses: [Pose], timestamp: NSDate = NSDate()) {
        _ = Flow(name: name, notes: notes, poses: poses)
        saveToPersistentStore()
    }
    
    func updateFlow(flow: Flow, name: String, notes: String?, poses: [Pose]) {
        flow.name = name
        flow.notes = notes
        flow.poses = NSOrderedSet(array: poses)
        saveToPersistentStore()
    }
    
    func deleteFlow(flow: Flow) {
        flow.managedObjectContext?.deleteObject(flow)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("The flow could not be saved.")
        }
    }
    
}