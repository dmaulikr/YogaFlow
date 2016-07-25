//
//  UserInputTableViewCell.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/18/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class UserInputTableViewCell: UITableViewCell {

    @IBOutlet weak var userInputTextField: UITextField!
    
    var flow: Flow?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateWithFlowName(flow: Flow) {
        userInputTextField.text = flow.name
    }
    
    func updateWithFlowNotes(flow: Flow) {
        userInputTextField.text = flow.notes
    }

}
