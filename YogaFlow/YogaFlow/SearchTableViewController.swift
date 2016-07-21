//
//  SearchTableViewController.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/13/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var poses = [Pose]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PoseController.fetchPoses { (poses) in
            self.poses = poses
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Buttons
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Functions
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        PoseController.searchPoses(poses, searchTerm: searchTerm)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poses.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("poseCell", forIndexPath: indexPath) as? SearchResultTableViewCell
        
        let pose = poses[indexPath.row]
        cell?.updateCellWithPose(pose)
        
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
