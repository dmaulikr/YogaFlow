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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flow = flow {
            updateWithFlow(flow)
        }
        
        
    }
    
    // MARK: - Buttons
    
    @IBAction func saveBtnPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Functions
    
    func updateWithFlow(flow: Flow) {
        
    }


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
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0, 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("inputCell", forIndexPath: indexPath)
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("poseCell", forIndexPath: indexPath)
            
            return cell
        }
    }


}
