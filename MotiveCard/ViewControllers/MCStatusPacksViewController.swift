//
//  MCStatusPacksViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/6/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCStatusPacksViewController: UIViewController {
    
    var dataSource: [MCPack] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        dataSource = MCHandlers.getLocalPacks()
        self.tableView.reloadData()
        
    }

}

extension MCStatusPacksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell?.textLabel?.text = dataSource[indexPath.row].packName as? String
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let wordsVC = self.storyboard?.instantiateViewControllerWithIdentifier("StatusWordsVC") as! MCStatusWordsViewController
        
        wordsVC.selectedPack = self.dataSource[indexPath.row]
        
        self.navigationController?.pushViewController(wordsVC, animated: true)
        
    }
    
}