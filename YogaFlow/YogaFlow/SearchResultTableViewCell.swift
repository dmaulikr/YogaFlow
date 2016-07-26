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
    @IBOutlet weak var addButtonImage: UIButton!
    
    weak var delegate: SearchResultDelegate?
    let plusImage = UIImage(named: "button-plus")
    let checkImage = UIImage(named: "button-check")
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        addButtonImage.setImage(plusImage, forState: .Normal)
        addButtonImage.imageView?.animationImages = [checkImage!, plusImage!]
        addButtonImage.imageView?.animationDuration = 1.0
        addButtonImage.imageView?.animationRepeatCount = 1
        addButtonImage.imageView?.startAnimating()
        
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
