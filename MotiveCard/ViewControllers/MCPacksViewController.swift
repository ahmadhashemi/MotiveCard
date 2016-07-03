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
    
    //var dataSourcePath: String =  "/Users/ahmad/Desktop/packs"
    var dataSourcePath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/packs"

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.translucent = false
        self.tabBarController?.tabBar.translucent = false
        
        self.makeDataSource()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MCPacksViewController.reloadTableView), name: "ReloadPacksTableView", object: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.hidden = false
        
    }
    
    func makeDataSource() {
        
        self.tempFunctionToMakeDataSource()
        dataSource = self.tempFunctionToGetDataSource()
        
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

////////

extension MCPacksViewController {
    
    func tempFunctionToGetDataSource() -> [MCPack] {
        
        let newPack = NSKeyedUnarchiver.unarchiveObjectWithFile(dataSourcePath) as! [MCPack]
        
        return newPack
        
    }
    
    func tempFunctionToMakeDataSource() {
        
        let newPack = MCPack()
        newPack.packName = "لغات دشوار"
        newPack.movieName = "Room"
        newPack.imageURL = NSURL(string: "https://i.ytimg.com/vi/MBkci3ujIus/maxresdefault.jpg")
        
        var newCard = MCCard()
        newCard.word = "zoomed down"
        newCard.definition = "الکی"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "boing"
        newCard.definition = "الکی"
        //newCard.box = 2
        //newCard.daysToReview = 2
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "batter"
        newCard.definition = "الکی"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "abracadabra"
        newCard.definition = "الکی"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "hobo"
        newCard.definition = "الکی"
        newPack.words.append(newCard)

        newCard = MCCard()
        newCard.word = "squirrels"
        newCard.definition = "الکی"
        newPack.words.append(newCard)
        
//
//        newCard = MCCard()
//        newCard.word = "splattered"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "tricking someone"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "make someone up in mind"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "alien"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "pulling teeth"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "alien"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "pulling teeth"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "indeed"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "octagon"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "leaf"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "rot"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "fridge"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "hammock"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "shed"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "stinky"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "floppy"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "bring something on yourself"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "puke something back up"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "dehydrated"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "going into convulsions"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "fold over"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "wobbly"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "filthy"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "pick-up"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "skylight"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "haystack"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "settle in"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "assess"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "being a plastic"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "unconfirmed"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "drape"
//        newPack.words.append(newCard)
        
        NSKeyedArchiver.archiveRootObject([newPack], toFile: dataSourcePath)
        
    }
    
}
