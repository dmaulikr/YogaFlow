//
//  FlowTableViewController.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/13/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class FlowTableViewController: UITableViewController {
    
    var flow: Flow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flow = flow {
            self.title = flow.name
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Poses"
        } else if section == 1 {
            return "Notes"
        } else {
            return "Date Created"
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let flow = flow else {return 0}
        if section == 0 {
            return flow.poses.count
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("poseCell", forIndexPath: indexPath)
            if let pose = flow?.poses[indexPath.row] as? Pose {
                cell.textLabel?.text = pose.name
                cell.detailTextLabel?.text = pose.sanskritName
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath)
            if let flow = flow {
                cell.textLabel?.text = flow.notes
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath)
            if let flow = flow {
                cell.textLabel?.text = flow.timestamp.stringValue()
            }
            return cell
        }
    }
    
    
    // MARK: - Navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPoseDetailViaFlowDetail", let indexPath = tableView.indexPathForSelectedRow {
            if let pose = flow?.poses[indexPath.row] as? Pose {
                let poseDetailVC = segue.destinationViewController as? PoseDetailViewController
                poseDetailVC?.pose = pose
            }
        }
        
        if segue.identifier == "toAddFlowViaDetail" {
            if let flow = flow {
                let addFlowTVC = segue.destinationViewController as? AddFlowTableViewController
                addFlowTVC?.flow = flow
            }
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
}
