//
//  MCMoviePacksViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/4/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCMoviePacksViewController: UIViewController {
    
    var dataSource: [MCPack] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "MCPacksTableViewCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "Cell")

        // Do any additional setup after loading the view.
    }

}

extension MCMoviePacksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MCPacksTableViewCell
        
        let thisPack = dataSource[indexPath.row]
        
        cell.nameLabel.text = thisPack.packName as? String
        cell.detailsLabel.text = "\(thisPack.words.count) لغت"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisPack = dataSource[indexPath.row]
        
        let alert = UIAlertController(title: thisPack.packName as? String, message: "از بابت دانلود و ذخیره مجموعه فوق مطمئن هستید؟", preferredStyle: .ActionSheet)
        
        alert.addAction(UIAlertAction(title: "بله", style: .Default, handler: { (action) in
            
            //let newPack = MCHandlers.makeLocalPackWithOnlinePack(thisPack)
            MCHandlers.addNewPackToLocalPacks(thisPack)
            
            self.downloadAndSaveSubtitle(for: thisPack)
            
            // temp
            // show success
            NSNotificationCenter.defaultCenter().postNotificationName("ReloadPacksTableView", object: nil)
            self.navigationController?.popToRootViewControllerAnimated(true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "بازگشت", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 170
    }

}

extension MCMoviePacksViewController {
    
    func downloadAndSaveSubtitle(for pack: MCPack) {
        
        if pack.subtitleURL?.absoluteString == "" {
            return
        }
        
        let request = NSMutableURLRequest(URL: pack.subtitleURL!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 20)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            let subtitleString = NSString(data: data!, encoding: 1)
            let savePath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/" + (pack.packName as! String) + ".srt"
            
            do {
                
                try subtitleString?.writeToFile(savePath, atomically: true, encoding: 1)
                
            } catch {
                
                print("error on in saving subtitle")
                
            }
            
        }
        
    }
    
}
