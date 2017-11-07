//
//  NoteTableViewCell.swift
//  Simple Note App
//
//  Created by Jinglin Liu on 11/5/17.
//  Copyright © 2017 Jinglin Liu. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell{

    @IBOutlet weak var titleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        }
}
