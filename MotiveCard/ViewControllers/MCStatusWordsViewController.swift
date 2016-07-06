//
//  MCStatusWordsViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/6/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCStatusWordsViewController: UIViewController {
    
    var selectedPack: MCPack = MCPack()
    
    var wordsAndBoxes: [String:[MCCard]] = ["1":[],"2":[],"3":[],"4":[],"5":[],"6":[]]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = self.selectedPack.packName as? String
        self.fillWordsAndBoxes()
        
    }

}

extension MCStatusWordsViewController {
    
    func fillWordsAndBoxes() {
        
        for index in 1...6 {
            wordsAndBoxes[String(index)] = selectedPack.words.filter({return $0.box == index})
        }
        
    }
    
}

extension MCStatusWordsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(section + 1)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (wordsAndBoxes[String(section + 1)]?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let thisSection = wordsAndBoxes[String(indexPath.section + 1)]
        
        cell?.textLabel?.text = thisSection![indexPath.row].word as? String
        
        return cell!
        
    }
    
}
