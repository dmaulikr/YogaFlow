//
//  AddFlowTableViewController.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/13/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class AddFlowTableViewController: UITableViewController {
    
    var flow: Flow?
    var userInputTVC: UserInputTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Buttons
    
    @IBAction func saveBtnPressed(sender: AnyObject) {
        if let textfield = userInputTVC {
            switch index {
            case 0:
                userInputTVC?.textLabel?.text = flow?.name
            case 1:
                userInputTVC?.textLabel?.text = flow?.notes
            default:
                <#code#>
            }
        }
        
        if let flow = flow {
            FlowController.sharedController.updateFlow(<#T##flow: Flow##Flow#>, name: <#T##String#>, notes: <#T##String?#>, poses: <#T##[Pose]#>)
        } else {
            FlowController.sharedController.createFlow(<#T##name: String##String#>, notes: <#T##String?#>, poses: <#T##[Pose]#>)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Functions
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Name"
        } else if section == 1 {
            return "Notes"
        } else {
            return "Poses"
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            if let flow = flow {
                return flow.poses.count
            } else {
                return 0
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("inputCell", forIndexPath: indexPath) as? UserInputTableViewCell
            if let flow = flow {
                cell?.updateWithFlowName(flow)
            }
            return cell ?? UserInputTableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("inputCell", forIndexPath: indexPath) as? UserInputTableViewCell
            if let flow = flow {
                cell?.updateWithFlowNotes(flow)
            }
            return cell ?? UserInputTableViewCell()
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("poseCell", forIndexPath: indexPath)
            if let flow = flow {
                guard let pose = flow.poses[indexPath.row] as? Pose else {return UITableViewCell()}
                cell.textLabel?.text = pose.name
                cell.detailTextLabel?.text = pose.sanskritName
            }
            return cell
        }
    }
    
    
}
