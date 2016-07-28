//
//  NotesLabelTableViewCell.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/28/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class NotesLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var notesLabel: UILabel!
    
    var flow: Flow?
    
    func updateWithNotes(flow: Flow) {
        notesLabel.text = flow.notes
        notesLabel.sizeToFit()
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
