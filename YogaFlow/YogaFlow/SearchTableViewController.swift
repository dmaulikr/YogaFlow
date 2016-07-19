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
        
    }
    
    // MARK: - Functions
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else {return}
        
        PoseController.searchPoses(poses, searchTerm: searchTerm)
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("poseCell", forIndexPath: indexPath) as? SearchResultTableViewCell

        cell?.updateCellWithPose()

        return cell ?? SearchResultTableViewCell()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
