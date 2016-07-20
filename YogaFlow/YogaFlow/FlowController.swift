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
    
    var mockFlows: [Flow] {
        let pose1 = Pose(name: "Big Toe Pose", dictionary: ["Sanskrit Name": "Padangusthasana", "Type": ["Core", "Seated"]])
        let pose2 = Pose(name: "Upward Plank Pose", dictionary: ["Sanskrit Name": "Purvottanasana", "Type": ["Strengthening"]])
        let pose3 = Pose(name: "Scale Pose", dictionary: ["Sanskrit Name": "Tolasana", "Type": ["Arm Balance", "Core"]])
        let pose4 = Pose(name: "Pigeon Pose", dictionary: ["Sanskrit Name": "Kapotasana", "Type": ["Backbend"]])
        let flow1 = Flow(name: "Sunrise", notes: "First thing in the AM", poses: [pose1!, pose2!])
        let flow2 = Flow(name: "Sunset", notes: "Last thing in the PM", poses: [pose3!, pose4!])
        return [flow1!, flow2!]
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