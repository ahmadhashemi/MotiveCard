//
//  MCMoviePacksViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/4/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCMoviePacksViewController: UIViewController {
    
    var dataSource: [MCOnlinePack] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension MCMoviePacksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MCMoviePacksTableViewCell
        
        let thisPack = dataSource[indexPath.row]
        
        cell.packNameLabel.text = thisPack.packName as String
        cell.packDetailsLabel.text = "\(thisPack.words.count) لغت"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisPack = dataSource[indexPath.row]
        
        let alert = UIAlertController(title: thisPack.packName as String, message: "از بابت دانلود و ذخیره مجموعه فوق مطمئن هستید؟", preferredStyle: .ActionSheet)
        
        alert.addAction(UIAlertAction(title: "بله", style: .Default, handler: { (action) in
            
            let newPack = MCHandlers.makeLocalPackWithOnlinePack(thisPack)
            MCHandlers.addNewPackToLocalPacks(newPack)
            
            // temp
            // show success
            NSNotificationCenter.defaultCenter().postNotificationName("ReloadPacksTableView", object: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "بازگشت", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }

}
