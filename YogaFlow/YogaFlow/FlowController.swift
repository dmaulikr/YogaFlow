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
        let cow = Pose(name: "Cow Pose", dictionary: ["Sanskrit Name": "Bitilasana", "Type": ["Chest Opening", "Backbend"]])
        let cat = Pose(name: "Cat Pose", dictionary: ["Sanskrit Name": "Marjaryasana", "Type": ["Core"]])
        let dog = Pose(name: "Downward-Facing Dog", dictionary: ["Sanskrit Name":"Adho Mukha Svanasana", "Type":["Forward Bend", "Standing", "Strengthening"]])
        let scale = Pose(name: "Scale Pose", dictionary: ["Sanskrit Name": "Tolasana", "Type": ["Arm Balance", "Core"]])
        let pigeon = Pose(name: "Pigeon Pose", dictionary: ["Sanskrit Name": "Kapotasana", "Type": ["Backbend"]])
        let flow1 = Flow(name: "Sunrise", notes: "First thing in the AM", poses: [cow, cat, dog])
        let flow2 = Flow(name: "Sunset", notes: "Last thing in the PM", poses: [scale, pigeon])
        return [flow1, flow2]
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