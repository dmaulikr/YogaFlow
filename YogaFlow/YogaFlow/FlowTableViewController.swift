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
        
        self.tableView.estimatedRowHeight = 40
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        if let flow = flow {
            self.title = flow.name
        }
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
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
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
            let cell = tableView.dequeueReusableCellWithIdentifier("notesCell", forIndexPath: indexPath) as? NotesLabelTableViewCell
            if let flow = flow {
                cell?.updateWithNotes(flow)
            }
            return cell ?? NotesLabelTableViewCell()
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("timestampCell", forIndexPath: indexPath)
            if let flow = flow {
                cell.textLabel?.text = flow.timestamp.stringValue()
            }
            return cell
        }
    }
    
    // MARK: - Navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPoseDetailViaFlowDetail", let indexPath = tableView.indexPathForSelectedRow {
            if let flow = flow, let pose = flow.poses[indexPath.row] as? Pose, let poseDetailPageVC = segue.destinationViewController as? FlowDetailPosesPageViewController {
                poseDetailPageVC.flow = flow
                poseDetailPageVC.pose = pose
            }
            
            // For just going to detail, without paging function:
            //            if let pose = flow?.poses[indexPath.row] as? Pose {
            //                let poseDetailVC = segue.destinationViewController as? PoseDetailViewController
            //                poseDetailVC?.pose = pose
            //            }
        }
        
        if segue.identifier == "toAddFlowViaDetail" {
            if let flow = flow {
                let addFlowTVC = segue.destinationViewController as? AddFlowTableViewController
                addFlowTVC?.flow = flow
            }
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        navigationItem.backBarButtonItem = backItem
    }
    
    
}
