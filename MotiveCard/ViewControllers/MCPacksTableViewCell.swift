//
//  MCPacksTableViewCell.swift
//  MotiveCard
//
//  Created by Ahmad on 7/3/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCPacksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        
        nameLabel.layer.shadowOffset = CGSizeMake(0, 2)
        nameLabel.layer.shadowOpacity = 0.3
        
        detailsLabel.layer.shadowOffset = nameLabel.layer.shadowOffset
        detailsLabel.layer.shadowOpacity = nameLabel.layer.shadowOpacity
        
        self.backgroundColor = UIColor.clearColor()
        
    }

}
