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
        
    }
    
    func makeDataSource() {
        
        self.tempFunctionToMakeDataSource()
        dataSource = [self.tempFunctionToGetDataSource()]
        
    }
    
}

extension MCPacksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let thisPack = dataSource[indexPath.row]
        
        cell?.textLabel?.text = thisPack.packName as? String
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let reviewVC = self.storyboard?.instantiateViewControllerWithIdentifier("ReviewVC") as! MCReviewViewController
        
        reviewVC.selectedPack = dataSource[indexPath.row]
        reviewVC.navigationItem.title = dataSource[indexPath.row].packName as? String
        
        self.navigationController?.pushViewController(reviewVC, animated: true)
        
    }
    
}

extension MCPacksViewController {
    
    func tempFunctionToGetDataSource() -> MCPack {
        
        let newPack = NSKeyedUnarchiver.unarchiveObjectWithFile("/Users/ahmad/Desktop/packData") as! MCPack
        
        return newPack
        
    }
    
    func tempFunctionToMakeDataSource() {
        
        let newPack = MCPack()
        newPack.packName = "لغات سخت"
        newPack.movieName = "Room"
        
        var newCard = MCCard()
        newCard.word = "zoomed down"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "boing"
        //newCard.box = 2
        //newCard.daysToReview = 2
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "batter"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "abracadabra"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "hobo"
        newPack.words.append(newCard)
//
//        newCard = MCCard()
//        newCard.word = "squirrels"
//        newPack.words.append(newCard)
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
        
        NSKeyedArchiver.archiveRootObject(newPack, toFile: "/Users/ahmad/Desktop/packData")
        
    }
    
}
