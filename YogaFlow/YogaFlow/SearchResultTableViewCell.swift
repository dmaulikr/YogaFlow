//
//  SearchResultTableViewCell.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/18/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var poseNameLabel: UILabel!
    @IBOutlet weak var sanskritNameLabel: UILabel!
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        print("Add button pressed")
    }
    
    func updateCellWithPose() {
        poseNameLabel.text = "Pose Name"
        sanskritNameLabel.text = "Sanskrit Name"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
