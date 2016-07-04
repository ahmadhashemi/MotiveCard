//
//  MCTableViewCell.swift
//  MotiveCard
//
//  Created by Mohamadreza on 4/14/1395 AP.
//  Copyright © 1395 Ahmad. All rights reserved.
//

import UIKit

class MCTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var Label: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
