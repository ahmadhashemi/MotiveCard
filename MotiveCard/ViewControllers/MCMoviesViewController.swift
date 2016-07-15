//
//  MCMoviesViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/4/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit
import Parse

class MCMoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [NSString : [MCOnlinePack]] = [:]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "MCPacksTableViewCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "Cell")
        
        self.fillDataSource()
        
    }

}

extension MCMoviesViewController {
    
    func fillDataSource() {
        
        let query = PFQuery(className: "Packs")
        
        query.findObjectsInBackgroundWithBlock { (packs, error) in
            
            if error != nil {
                print("fetch error")
            }
            
            self.makeDataSourceWithReponse(packs!)
            self.tableView.reloadData()
            
        }
        
    }
    
    func makeDataSourceWithReponse(response: [PFObject]) {
        
        for pack in response {
            
            let aPack = MCOnlinePack()
            
            aPack.movieName = pack["MovieName"] as! String
            aPack.packName = pack["PackName"] as! String
            aPack.words = pack["Words"] as! [String]
            aPack.imageURL = NSURL(string: pack["ImageURL"] as! String)!
            
            if dataSource.keys.contains(aPack.movieName) {
                dataSource[aPack.movieName]?.append(aPack)
            } else {
                dataSource[aPack.movieName] = [aPack]
            }
            
        }
        
    }
    
}

extension MCMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.keys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MCPacksTableViewCell
        
        let cellTitle = Array(dataSource.keys)[indexPath.row] as String
        let cellPacks = self.dataSource[cellTitle]
        
        //cell.movieNameLabel.text = cellTitle
        //cell.movieDetailsLabel?.text = "\((cellPacks?.count)!) بسته لغت"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let packsVC = self.storyboard?.instantiateViewControllerWithIdentifier("MoviePacksVC") as! MCMoviePacksViewController
        
        let cellTitle = Array(dataSource.keys)[indexPath.row] as String
        let cellPacks = self.dataSource[cellTitle]
        
        packsVC.dataSource = cellPacks!
        
        self.navigationController?.pushViewController(packsVC, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 170;
    }
    
}
