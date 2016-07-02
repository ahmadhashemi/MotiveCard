//
//  MCCardViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/2/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCCardViewController: UIViewController {
    
    var selectedCard = MCCard()
    var cardIndex: NSInteger = 0
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.configureViews()
        
    }

    func configureViews() {
        
        self.indexLabel.text = "\(cardIndex)"
        self.wordLabel.text = "\(selectedCard.word!)"
        
    }

}
