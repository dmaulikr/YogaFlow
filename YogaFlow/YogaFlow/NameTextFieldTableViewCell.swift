//
//  NameTextFieldTableViewCell.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/28/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class NameTextFieldTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var flow: Flow?
    
    func updateWithFlowName(flow: Flow) {
        nameTextField.text = flow.name
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
