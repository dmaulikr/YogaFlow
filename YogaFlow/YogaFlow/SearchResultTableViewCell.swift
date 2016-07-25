//
//  SearchResultTableViewCell.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/18/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    var poses = [Pose]()
    
    @IBOutlet weak var poseNameLabel: UILabel!
    @IBOutlet weak var sanskritNameLabel: UILabel!
    
    weak var delegate: SearchResultDelegate?
    
    @IBAction func addButtonPressed(sender: AnyObject) {
//        if let name = poseNameLabel.text {
//            let pose = Pose(name: name, dictionary: [:])
//            poses.append(pose)
//        }
        delegate?.poseSelected(self)
        print("Add button pressed")
    }
    
    func updateCellWithPose(pose: Pose) {
        poseNameLabel.text = pose.name
        sanskritNameLabel.text = pose.sanskritName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

protocol SearchResultDelegate: class {
    func poseSelected(cell: SearchResultTableViewCell)
}
