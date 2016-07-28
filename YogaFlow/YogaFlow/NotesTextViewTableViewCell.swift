//
//  NotesTextViewTableViewCell.swift
//  YogaFlow
//
//  Created by Emily Mearns on 7/28/16.
//  Copyright © 2016 Emily Mearns. All rights reserved.
//

import UIKit

class NotesTextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var notesTextView: UITextView!
    var flow: Flow?
    
    func updateWithNotes(flow: Flow) {
        notesTextView.text = flow.notes
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
