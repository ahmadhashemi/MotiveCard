//
//  MCResultViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/2/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCResultViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var correctCountLabel: UILabel!
    @IBOutlet weak var wrongCountLabel: UILabel!
    
    var corectCount: NSInteger = 0
    var wrongCount: NSInteger = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.correctCountLabel.text = "\(corectCount)"
        self.wrongCountLabel.text = "\(wrongCount)"
        
        self.scoreLabel.text = "\(Float(corectCount)/Float(corectCount + wrongCount) * 100)"
        
    }

    @IBAction func backButtonTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }

}
