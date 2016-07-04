//
//  MCPacksViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/2/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCPacksViewController: UIViewController {
    
    var dataSource: [MCPack] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.translucent = false
        self.tabBarController?.tabBar.translucent = false
        
        self.makeDataSource()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Pack-Add"), style: .Plain, target: self, action: Selector("addNewPackButtonTapped:"))
        
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MCPacksViewController.reloadTableView), name: "ReloadPacksTableView", object: nil)
          NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("reloadTableView"), name: "ReloadPacksTableView", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = false
        
    }
    
    func makeDataSource() {
        
        //MCHandlers.tempFunctionToMakeDataSource()
        dataSource = MCHandlers.getLocalPacks()
        
    }
    
}

extension MCPacksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MCPacksTableViewCell
        
        let thisPack = dataSource[indexPath.row]
        
        cell.tintView.backgroundColor = self.randomColorForTintView()
        cell.movieImageView.moa.url = thisPack.imageURL?.absoluteString
        cell.movieNameLabel.text = thisPack.movieName as? String
        cell.packNameLabel.text = thisPack.packName as? String
        cell.packDetailsLabel.text = self.detailsStringForPack(thisPack)
        
        return cell
        
    }
    
    func randomColorForTintView() -> UIColor {
        
        let colors = [UIColor(red:0.064,  green:0.115,  blue:0.235, alpha:0.5),
                      UIColor(red:0.098,  green:0.392,  blue:0.118, alpha:0.5),
                      UIColor(red:0.392,  green:0.098,  blue:0.098, alpha:0.5),
                      UIColor(red:0.098,  green:0.376,  blue:0.392, alpha:0.5)]
        
        let randomIndex = arc4random_uniform(UInt32(colors.count))
        
        return colors[Int(randomIndex)]
    }
    
    func detailsStringForPack(pack: MCPack) -> String {
        
        let packDetails: String
        
        let wordsToReview = pack.words.filter { (card) -> Bool in
            return card.daysToReview == 1
        }
        
        if (wordsToReview.count == 0) {
            
            let unreviewdWords = pack.words.filter { (card) -> Bool in
                return card.box < 7
            }
            
            if unreviewdWords.count == 0 {
                packDetails = "مرور این بسته به پایان رسیده است"
            } else {
                packDetails = "مرور بعدی خالی است"
            }
            
        } else {
            
            packDetails = "مرور بعدی : \(wordsToReview.count) لغت"
            
        }
        
        return packDetails
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        let selectedPack = dataSource[indexPath.row]
//        
//        let alert = UIAlertController(title: selectedPack.packName as? String, message: nil, preferredStyle: .ActionSheet)
//        
//        alert.addAction(UIAlertAction(title: "مرور", style: .Default, handler: { (action) in
//            
//            let reviewVC = self.storyboard?.instantiateViewControllerWithIdentifier("ReviewVC") as! MCReviewViewController
//            
//            reviewVC.selectedPack = selectedPack
//            reviewVC.navigationItem.title = selectedPack.packName as? String
//            
//            reviewVC.hidesBottomBarWhenPushed = true
//            
//            self.navigationController?.pushViewController(reviewVC, animated: true)
//            
//        }))
//        
//        alert.addAction(UIAlertAction(title: "ریست پیشرفت", style: .Destructive, handler: { (action) in
//            
//            
//            
//        }))
//        
//        alert.addAction(UIAlertAction(title: "بازگشت", style: .Cancel, handler: nil))
//        
//        self.presentViewController(alert, animated: true, completion: nil)
        
        let selectedPack = dataSource[indexPath.row]
        
        let reviewVC = self.storyboard?.instantiateViewControllerWithIdentifier("ReviewVC") as! MCReviewViewController
        
        reviewVC.selectedPack = selectedPack
        reviewVC.navigationItem.title = selectedPack.packName as? String
        
        reviewVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(reviewVC, animated: true)
        
    }
    
    func reloadTableView() {
        
        self.tableView.reloadData()
        
    }
    
}

extension MCPacksViewController {
    
    func addNewPackButtonTapped(sender: UIBarButtonItem) {
        
        let moviesVC = self.storyboard?.instantiateViewControllerWithIdentifier("MoviesVC") as! MCMoviesViewController
        
        self.navigationController?.pushViewController(moviesVC, animated: true)
        
    }
    
}
