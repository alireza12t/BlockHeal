//
//  AcceptedRequestTableViewCell.swift
//  BlockHeal
//
//  Created by ali on 6/19/20.
//  Copyright © 2020 Alireza. All rights reserved.
//

import UIKit

class AcceptedRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var doctorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


class RejectedRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var doctorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


class NewRequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
