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
    @IBOutlet weak var posterAddressField: UITextField!
    @IBOutlet weak var subtitleAddressField: UITextField!
    @IBOutlet weak var movieAddressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addWordsButtonTapped(sender: UIButton) {
        
        guard movieNameField.text != "" else {
            let message = "نام فیلم را وارد نمایید"
            TSMessage.showNotificationWithTitle(message, type: .Warning)
            movieNameField.becomeFirstResponder()
            print("movie name is needed");
            return
        }
        
        guard packNameField.text != "" else {
            let message = "نام بسته را وارد نمایید"
            TSMessage.showNotificationWithTitle(message, type: .Warning)
            packNameField.becomeFirstResponder()
            print("pack name is needed");
            return
        }
        
        let addWordsVC = self.storyboard?.instantiateViewControllerWithIdentifier("NewPackWordsVC") as! MCNewPackWordsViewController
        
        let newOnlinePack = MCPack()
        
        newOnlinePack.packName = self.packNameField.text!
        newOnlinePack.movieName = self.movieNameField.text!
        newOnlinePack.imageURL = NSURL(string: self.posterAddressField.text!)!
        newOnlinePack.subtitleURL = NSURL(string: self.subtitleAddressField.text!)!
        newOnlinePack.movieURL = NSURL(string: self.movieNameField.text!)!
        
        addWordsVC.newOnlinePack = newOnlinePack
        
        self.packNameField.text = ""
        self.movieNameField.text = ""
        self.posterAddressField.text = ""
        self.subtitleAddressField.text = ""
        self.movieNameField.text = ""
        
        self.navigationController?.pushViewController(addWordsVC, animated: true)
        
    }

}
