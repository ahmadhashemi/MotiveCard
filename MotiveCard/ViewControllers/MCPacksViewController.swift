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
        self.handlePacks()
        
        self.navigationController?.navigationBar.barStyle = .Black
        
        let cellNib = UINib(nibName: "MCPacksTableViewCell", bundle: NSBundle.mainBundle())
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "Cell")
        
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
        
        //cell.tintView.backgroundColor = self.randomColorForTintView()
        cell.coverImageView.moa.url = thisPack.imageURL?.absoluteString
        cell.nameLabel.text = thisPack.movieName! as String
        cell.detailsLabel.text = thisPack.packName! as String
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let selectedPack = dataSource[indexPath.row]
        
        let reviewVC = self.storyboard?.instantiateViewControllerWithIdentifier("ReviewVC") as! MCReviewViewController
        
        reviewVC.allPacks = self.dataSource
        reviewVC.selectedPack = selectedPack
        reviewVC.navigationItem.title = selectedPack.packName as? String
        
        reviewVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(reviewVC, animated: true)
        
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
    
    func reloadTableView() {
        
        self.makeDataSource()
        self.tableView.reloadData()
        
    }
    
}

extension MCPacksViewController {
    
    func addNewPackButtonTapped(sender: UIBarButtonItem) {
        
        let moviesVC = self.storyboard?.instantiateViewControllerWithIdentifier("MoviesVC") as! MCMoviesViewController
        
        self.navigationController?.pushViewController(moviesVC, animated: true)
        
    }
    
}

extension MCPacksViewController {
    
    func handlePacks() {
        
        self.removePacks()
        
        if ((NSUserDefaults.standardUserDefaults().objectForKey("FirstRun")) != nil) {
            return
        }
        NSUserDefaults.standardUserDefaults().setObject("NO", forKey: "FirstRun")
        
        self.makePacks()
        
    }
    
    func removePacks() {
        
        var packs = MCHandlers.getLocalPacks()
        packs.removeAll()
        MCHandlers.saveLocalPacks(packs)
        
    }
    
    func makePacks() {
        
        let packs: NSMutableArray = []
        var newPack = MCPack()
        var newCard = MCCard()
        
        // leon
        
//        newPack = MCPack()
//        newPack.movieName = "Leon"
//        newPack.packName = "لغات ضروری"
//        newPack.imageURL = NSURL(string: "http://ahmadhashemi.com/motivecard/leon.jpg")
//        newPack.movieURL = NSURL(string: "http://as7.asset.aparat.com/aparat-video/a_01d72f5l6qnk0lp6n29n2pq74n99384noq4249275418-733a__b53da.mp4")
//        
//        newCard = MCCard()
//        newCard.word = "call you back"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "pick up"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "productive"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "leave"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "hire"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "license"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "keep calm"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "cursing"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "rent"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "afford"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "filthy"
//        newPack.words.append(newCard)
//        
//        packs.addObject(newPack)
        
        //
        
        newPack = MCPack()
        newPack.movieName = "The Revenant"
        newPack.packName = "لغات ضروری"
        newPack.imageURL = NSURL(string: "http://ahmadhashemi.com/motivecard/revenant.jpg")
        newPack.movieURL = NSURL(string: "http://ahmadhashemi.com/motivecard/Revenant.mp4")
        
        newCard = MCCard()
        newCard.word = "give up"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "haul"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "spit"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "savage"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "keep the pelts"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "miracle"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "twist"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "grab a breath"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "sacrament"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "begging"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "burial"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "proud of"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "fortunately"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "trace"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "supposed to"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "alongside"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "justify"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "revenge"
        newPack.words.append(newCard)
        
        packs.addObject(newPack)
        
        // avengers
        
        newPack = MCPack()
        newPack.movieName = "The Avengers"
        newPack.packName = "لغات ضروری"
        newPack.imageURL = NSURL(string: "http://ahmadhashemi.com/motivecard/theavengers.jpg")
        newPack.movieURL = NSURL(string: "http://ahmadhashemi.com/motivecard/Avengers.mp4")
        
        newCard = MCCard()
        newCard.word = "immediately"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "in fact"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "trust me"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "pretending"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "slipped out"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "unable to"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "take the weight"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "deserve"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "tangled in"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "escape hatch"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "self-destruct"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "effort"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "short-range"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "old times"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "assassin"
        newPack.words.append(newCard)
        
        newCard = MCCard()
        newCard.word = "become"
        newPack.words.append(newCard)
        
        packs.addObject(newPack)
        
        // room
        
//        newPack = MCPack()
//        newPack.movieName = "Room"
//        newPack.packName = "لغات ضروری"
//        newPack.imageURL = NSURL(string: "http://ahmadhashemi.com/motivecard/room.jpg")
//        newPack.movieURL = NSURL(string: "http://as4.asset.aparat.com/aparat-video/a_b9odomf31272qmmmn092mp2p0n426omm5o67p5694876-381b__c13d5.mp4")
//        
//        newCard = MCCard()
//        newCard.word = "zoomed down"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "boing"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "batter"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "abracadabra"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "hobo"
//        newPack.words.append(newCard)
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
//        newCard.word = "dehydrated"
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
//        newCard.word = "unconfirmed"
//        newPack.words.append(newCard)
//        
//        newCard = MCCard()
//        newCard.word = "drape"
//        newPack.words.append(newCard)
//        
//        packs.addObject(newPack)
        
        //
        MCHandlers.saveLocalPacks(packs as! Array)
        
    }
    
}
