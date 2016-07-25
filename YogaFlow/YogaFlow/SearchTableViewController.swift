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
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func segController(sender: AnyObject) {
        if segControlOutlet.selectedSegmentIndex == 0 {
            tableView.reloadData()
            print("Search Controller")
        }
        if segControlOutlet.selectedSegmentIndex == 1 {
            tableView.reloadData()
            print("Added Controller")
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
        default:
            let pose = addedPoses[indexPath.row]
            cell?.updateCellWithPose(pose)
            cell?.delegate = self
        }
        return cell ?? SearchResultTableViewCell()
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toPoseDetailViaSearch",
            let poseDetailVC = segue.destinationViewController as? PoseDetailViewController,
            let poseCell = sender as? SearchResultTableViewCell,
            let indexPath = tableView.indexPathForCell(poseCell) {
            poseDetailVC.pose = poses[indexPath.row]
        }
    }
    

    
}
