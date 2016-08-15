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
    var poses: [Pose] = []
    var nameTableViewCell: NameTextFieldTableViewCell?
    var notesTableViewCell: NotesTextViewTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
//        if let flow = flow,  {
//            
//        }
        nameTableViewCell?.nameTextField.resignFirstResponder()
        notesTableViewCell?.notesTextView.resignFirstResponder()
    }
    
    // MARK: - Buttons
    
    @IBAction func saveBtnPressed(sender: AnyObject) {
        guard let nameCell = nameTableViewCell, notesCell = notesTableViewCell, name = nameCell.nameTextField.text, notes = notesCell.notesTextView.text where name.characters.count > 0 else {
            let alertController = UIAlertController(title: "Your flow needs a name", message: "Please make sure that you have written a name for your flow sequence.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }

        if let flow = flow, poses = flow.poses.array as? [Pose] {
            FlowController.sharedController.updateFlow(flow, name: name, notes: notes, poses: poses)
        } else {
            FlowController.sharedController.createFlow(name, notes: notes, poses: poses)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func unwindToAddFlowTVC(segue: UIStoryboardSegue) {}
    
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
                return poses.count
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as? NameTextFieldTableViewCell
            if let flow = flow {
                cell?.updateWithFlowName(flow)
            }
            nameTableViewCell = cell
            return cell ?? NameTextFieldTableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("notesCell", forIndexPath: indexPath) as? NotesTextViewTableViewCell
            if let flow = flow {
                cell?.updateWithNotes(flow)
            }
            notesTableViewCell = cell
            return cell ?? NotesTextViewTableViewCell()
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("poseCell", forIndexPath: indexPath)
            if let flow = flow {
                guard let pose = flow.poses[indexPath.row] as? Pose else {return UITableViewCell()}
                cell.textLabel?.text = pose.name
                cell.detailTextLabel?.text = pose.sanskritName
            } else {
                let pose = poses[indexPath.row]
                cell.textLabel?.text = pose.name
                cell.detailTextLabel?.text = pose.sanskritName
            }
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 75
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSearchViaAddFlowTVC" {
            if let flow = flow,
                let searchTVC = segue.destinationViewController as? SearchTableViewController {
                searchTVC.addedPoses = flow.poses.array as? [Pose] ?? []
            }
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    
}
