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
        
        searchBar.placeholder = "Search for pose by name"
        searchBar.barTintColor = UIColor(red: 0.349, green: 0.349, blue: 0.349, alpha: 1.00)
        searchBar.keyboardAppearance = .Dark
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("unwindToAddFlowTVC", sender: self)
    }
    
    @IBAction func segController(sender: AnyObject) {
        if segControlOutlet.selectedSegmentIndex  == 0 {
            searchBar.hidden = false
            self.tableView.setContentOffset(CGPointMake(0, -64), animated: false)
        } else {
            searchBar.hidden = true
            self.tableView.setContentOffset(CGPointMake(0, -20), animated: false)
        }
        tableView.reloadData()
    }
    
    // MARK: - Functions
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercaseString else {return}
        
        poses = PoseController.searchPoses(poses, searchTerm: searchTerm)
        tableView.reloadData()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchTerm = searchBar.text else {return}
        
        poses = PoseController.searchPoses(backup, searchTerm: searchTerm)
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
            cell?.addButtonImage.hidden = false
        case 1:
            let pose = addedPoses[indexPath.row]
            cell?.updateCellWithPose(pose)
            cell?.delegate = self
            cell?.addButtonImage.hidden = true
            
        default:
            break
        }
        return cell ?? SearchResultTableViewCell()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if segControlOutlet.selectedSegmentIndex == 1 {
            tableView.setEditing(true, animated: true)
            return true
        } else {
            tableView.setEditing(false, animated: false)
            return false
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let pose = addedPoses[indexPath.row]
            guard let index = addedPoses.indexOf(pose) else {return}
            addedPoses.removeAtIndex(index)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
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
            } else {
                addFlowTVC.poses = addedPoses
            }
        }
    }
    
    
    
}
