//
//  PoseDetailViewController.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/13/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class PoseDetailViewController: UIViewController {

    @IBOutlet weak var poseNameLabel: UILabel!
    @IBOutlet weak var sanskritNameLabel: UILabel!
    @IBOutlet weak var poseTypeLabel: UILabel!
    @IBOutlet weak var poseImageView: UIImageView!
    
    var pose: Pose?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let pose = pose {
            updateWithPose(pose)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateWithPose(pose: Pose) {
        poseNameLabel.text = pose.name
        sanskritNameLabel.text = pose.sanskritName
        poseTypeLabel.text = "Type: \(pose.types.array.flatMap({$0.name}))"
    }

}
