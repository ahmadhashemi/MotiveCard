//
//  MCNewPackViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/6/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCNewPackViewController: UIViewController {
    
    @IBOutlet weak var movieNameField: UITextField!
    @IBOutlet weak var packNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addWordsButtonTapped(sender: UIButton) {
        
        guard movieNameField.text != "" else {
            print("movie name is needed");
            return
        }
        
        guard packNameField.text != "" else {
            print("pack name is needed");
            return
        }
        
        let addWordsVC = self.storyboard?.instantiateViewControllerWithIdentifier("NewPackWordsVC") as! MCNewPackWordsViewController
        
        let newOnlinePack = MCOnlinePack()
        
        newOnlinePack.packName = self.packNameField.text!
        newOnlinePack.movieName = self.movieNameField.text!
        
        addWordsVC.newOnlinePack = newOnlinePack
        
        self.packNameField.text = ""
        self.movieNameField.text = ""
        
        self.navigationController?.pushViewController(addWordsVC, animated: true)
        
    }

}
