//
//  FlowListTableViewController.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/13/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class FlowListTableViewController: UITableViewController {
    
//    var flows: [Flow] = []
    var flowListTVC: FlowListTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        navigationItem.title = "namaste"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "AnandaNeptouch", size: 22)!]
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "yfheader"), forBarMetrics: .Default)
        
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FlowController.sharedController.flows.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("flowCell", forIndexPath: indexPath)
        
        let flow = FlowController.sharedController.flows[indexPath.row]
        cell.textLabel?.text = flow.name
        cell.detailTextLabel?.text = flow.timestamp.stringValue()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let flow = FlowController.sharedController.flows[indexPath.row]
            FlowController.sharedController.deleteFlow(flow)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toFlowDetail", let indexPath = tableView.indexPathForSelectedRow {
            let flow = FlowController.sharedController.flows[indexPath.row]
            let flowTVC = segue.destinationViewController as? FlowTableViewController
            flowTVC?.flow = flow
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
}







