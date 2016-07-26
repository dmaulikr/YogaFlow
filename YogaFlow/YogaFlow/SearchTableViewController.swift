//
//  SearchTableViewController.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/13/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate, SearchResultDelegate {
    
    @IBOutlet weak var segControlOutlet: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var poses = [Pose]()
    var addedPoses = [Pose]()
    var backup = [Pose]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PoseController.fetchPoses { (poses) in
            self.poses = poses
            self.backup = poses
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToAddFlowTVC", sender: self)
    }
    
    @IBAction func segController(sender: AnyObject) {
        if segControlOutlet.selectedSegmentIndex == 0 {
            tableView.reloadData()
        }
        if segControlOutlet.selectedSegmentIndex == 1 {
            tableView.reloadData()
        }
    }
    
    // MARK: - Functions
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        poses = PoseController.searchPoses(poses, searchTerm: searchTerm)
        tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchTerm = searchBar.text else {return}
        
        poses = PoseController.searchPoses(poses, searchTerm: searchTerm)
        if poses.count == 0 {
            poses = backup
        }
        tableView.reloadData()
    }
    
    // MARK: - Search Result Delegate
    
    func poseSelected(cell: SearchResultTableViewCell) {
        guard let indexPath = tableView.indexPathForCell(cell) else {
            return
        }
        let pose = poses[indexPath.row]
        addedPoses.append(pose)
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segControlOutlet.selectedSegmentIndex {
        case 0:
            return poses.count
        default:
            return addedPoses.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("poseCell", forIndexPath: indexPath) as? SearchResultTableViewCell
        
        switch segControlOutlet.selectedSegmentIndex {
        case 0:
            let pose = poses[indexPath.row]
            cell?.updateCellWithPose(pose)
            cell?.delegate = self
            cell?.addButtonImage.setImage(UIImage(named: "button-plus"), forState: .Normal)
            cell?.addButtonImage.enabled = true
        case 1:
            let pose = addedPoses[indexPath.row]
            cell?.updateCellWithPose(pose)
            cell?.delegate = self
            cell?.addButtonImage.setImage(UIImage(named: "button-arrange"), forState: .Normal)
            cell?.addButtonImage.enabled = false
            
        default:
            break
        }
        return cell ?? SearchResultTableViewCell()
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if segControlOutlet.selectedSegmentIndex == 1 {
            return true
        } else {
            return false
        }
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            if editingStyle == .Delete {
                let pose = addedPoses[indexPath.row]
                guard let index = addedPoses.indexOf(pose) else {return}
                addedPoses.removeAtIndex(index)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        //        else if editingStyle == .Insert {
        //            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        if segControlOutlet.selectedSegmentIndex == 1 {
            let pose = addedPoses[fromIndexPath.row]
            addedPoses.removeAtIndex(fromIndexPath.row)
            addedPoses.insert(pose, atIndex: toIndexPath.row)
        }
    }
    
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if segControlOutlet.selectedSegmentIndex == 1 {
            return true
        } else {
            return false
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPoseDetailViaSearch",
            let poseDetailVC = segue.destinationViewController as? PoseDetailViewController,
            let poseCell = sender as? SearchResultTableViewCell,
            let indexPath = tableView.indexPathForCell(poseCell) {
            switch segControlOutlet.selectedSegmentIndex {
            case 0:
                poseDetailVC.pose = poses[indexPath.row]
            default:
                poseDetailVC.pose = addedPoses[indexPath.row]
            }
        }
        
        if segue.identifier == "unwindToAddFlowTVC", let addFlowTVC = segue.destinationViewController as? AddFlowTableViewController {
            if addFlowTVC.flow != nil {
                addFlowTVC.flow?.poses = NSOrderedSet(array: addedPoses)
                
                // TODO: Make sure you delete this code when you uncomment ^^^^ or else // OIF
                //                if var flowPoses = addFlowTVC.flow?.poses.array as? [Pose] {
                //                    flowPoses.appendContentsOf(addedPoses)
                //                    addFlowTVC.flow?.poses = NSOrderedSet(array: flowPoses)
                //                }
            } else {
                addFlowTVC.poses = addedPoses
            }
        }
    }
    
    
    
}
