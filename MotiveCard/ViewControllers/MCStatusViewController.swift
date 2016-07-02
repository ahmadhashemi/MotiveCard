//
//  MCStatusViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/3/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCStatusViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var titleString: String?
    var textString: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.titleLabel.text = titleString
        self.textLabel.text = textString
        
    }
    
    @IBAction func backButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
