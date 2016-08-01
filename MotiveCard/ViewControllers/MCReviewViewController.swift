//
//  MCReviewViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/2/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import AVKit

class MCReviewViewController: UIViewController {

    @IBOutlet weak var pageView: UIView!
    
    var allPacks = [MCPack]()
    var selectedPack = MCPack()
    var cardsToReview: [MCCard] = []
    
    var pageVC = UIPageViewController()
    var selectedCardIndex = 0
    
    var newHistory = MCHistory()
    
    var moviePlayer = MPMoviePlayerViewController()
    
    var containedTime: Int? = nil
}

extension MCReviewViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        newHistory.pack = selectedPack
        
        moviePlayer = MPMoviePlayerViewController(contentURL: self.selectedPack.movieURL!)
        
        self.findCardsToReview()
        self.configurePageView()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("moviePlayStarted"), name: "MPMoviePlayerPlaybackStateDidChangeNotification: ", object: nil)
        
    }
    
    func findCardsToReview() {
        
        cardsToReview = selectedPack.words.filter({ (card) -> Bool in
            let result = card.daysToReview == 1 && card.box < 7
            return result
        })
        
    }
    
    func configurePageView() {
        
        pageVC = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        
        let pageVCView = pageVC.view
        pageVCView.frame = self.pageView.bounds
        self.pageView.addSubview(pageVCView)
        
        self.goToNextCardViewController()
        
    }

    
}

extension MCReviewViewController {
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        
        let selectedCard = cardsToReview[selectedCardIndex]
        
        let alert = UIAlertController(title: selectedCard.word as? String, message: selectedCard.definition as? String, preferredStyle: .ActionSheet)
        
        alert.addAction(UIAlertAction(title: "حدس زدم", style: .Default, handler: { (action) in
            
            self.guessedDefinitionForCard(selectedCard, correct: true)
            self.selectedCardIndex = self.selectedCardIndex + 1
            self.goToNextCardViewController()
            
        }));
        
        alert.addAction(UIAlertAction(title: "حدس نزدم", style: .Default, handler: { (action) in
            
            self.guessedDefinitionForCard(selectedCard, correct: false)
            self.selectedCardIndex = self.selectedCardIndex + 1
            self.goToNextCardViewController()
            
        }));
        
        alert.addAction(UIAlertAction(title: "بازگشت", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func goToNextCardViewController() {
        
        let cardVC = self.storyboard?.instantiateViewControllerWithIdentifier("CardVC") as! MCCardViewController
        
        if selectedCardIndex == cardsToReview.count { // should not go to next card view controller. but why?
            
            if cardsToReview.count == 0 { // because there was no cards at all.
                
                self.reviewHasNoCards()
                
            } else {
                
                self.reviewFinished() // because review is finished.
                
            }
            
            return
        }
        
        cardVC.selectedCard = cardsToReview[selectedCardIndex]
        cardVC.cardIndex = cardsToReview.count - selectedCardIndex
        
        pageVC.setViewControllers([cardVC], direction: .Forward, animated: true, completion: nil)
        
    }
    
    @IBAction func movieButtonTapped(sender: UIButton) {
        
        let reviewCard = cardsToReview[selectedCardIndex]
        
        containedTime = MCHandlers.search(forWord: reviewCard.word as? String, inMovie: self.selectedPack.movieName as? String)
        
        if containedTime == nil {
            print("couldn't fine time")
            return
        }else{
            self.moviePlayStarted()
        }
        
        print(containedTime)
        
        //self.presentMoviePlayerViewControllerAnimated(moviePlayer)
        
    }
    
    func moviePlayStarted() {
        
        let beginTime = CMTimeMakeWithSeconds(Float64(containedTime!) - (30 as Float64), 1)
        let delay = 30 as! Double//integer ( 60 seconds for our app )
        //let endTime = beginTime.seconds + delay
        
        let player = AVPlayer(URL: self.selectedPack.movieURL!) // Local Player
        
        
        let playerController = AVPlayerViewController()
        playerController.player = player
        self.presentViewController(playerController, animated: true) {
            player.currentItem?.seekToTime(beginTime)
            player.performSelector(Selector("pause"), withObject: nil, afterDelay: delay)
            
            
            func pause(player : AVPlayer){
                player.pause()
            }
        }
    }

        
        
     /*   if (moviePlayer.moviePlayer.playbackState == .Playing) {
            
            moviePlayer.moviePlayer.currentPlaybackTime = Double(containedTime!) - 30;
            //containedTime = nil
            
        }*/
        
    
    
}

extension MCReviewViewController {
    
    func guessedDefinitionForCard(card: MCCard, correct: Bool) {
        
        if correct {
            
            card.box = card.box + 1
            card.daysToReview = card.box
            
            newHistory.correctWords.addObject(card)
            
        } else {
            
            card.box = 1
            card.daysToReview = 1
            
            newHistory.wrongWords.addObject(card)
            
        }
        
    }
    
}

//////// when review is finished:

extension MCReviewViewController {
    
    func reviewFinished() {
        
        self.configureNotReviewedCards()
        self.saveConfiguredPack()
        self.saveNewHistoryItem()
        
        self.moveViewToFinishStatus()
        
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadPacksTableView", object: nil)
        
    }
    
    func moveViewToFinishStatus() {
        
        let resultVC = self.storyboard?.instantiateViewControllerWithIdentifier("ResultVC") as! MCResultViewController
        
        resultVC.corectCount = newHistory.correctWords.count
        resultVC.wrongCount = newHistory.wrongWords.count
        
        resultVC.modalTransitionStyle = .FlipHorizontal
        
        self.navigationController?.presentViewController(resultVC, animated: true) {
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    func saveNewHistoryItem() {
        
        MCHandlers.addNewHistoryToLocalHistory(self.newHistory)
        
    }
    
}

//////// when has no cards to review (both no this time and not at all)

extension MCReviewViewController {
    
    func reviewHasNoCards() {
        
        self.configureNotReviewedCards()
        self.saveConfiguredPack()
        
        self.moveViewToNoCardsStatus()
        
        NSNotificationCenter.defaultCenter().postNotificationName("ReloadPacksTableView", object: nil)
        
    }
    
    func moveViewToNoCardsStatus() {
        
        let title: NSString
        let text: NSString
        
        let remainingCardsInPack = self.selectedPack.words.filter { (card) -> Bool in
            return card.box < 7
        }
        
        if remainingCardsInPack.count == 0 {
            
            title = "مرور این بسته به پایان رسیده است"
            text = ""
            
        } else {
            
            title = "جعبه مرور خالی است"
            text = "لغتی برای مرور وجود ندارد. جهت ادامه روند مرور، بار دیگر جعبه را باز نمایید"
            
        }
        
        let statusVC = self.storyboard?.instantiateViewControllerWithIdentifier("StatusVC") as! MCStatusViewController
        
        statusVC.titleString = title as String
        statusVC.textString = text as String
        
        statusVC.modalTransitionStyle = .FlipHorizontal
        
        self.navigationController?.presentViewController(statusVC, animated: true) {
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
}

//////// in common for finish and nocard:

extension MCReviewViewController {
    
    func configureNotReviewedCards() {
        
        var notReviewedWords = self.selectedPack.words.filter { (card) -> Bool in
            return !cardsToReview.contains(card)
        }
        
        notReviewedWords = notReviewedWords.map { (card) -> MCCard in
            card.daysToReview = card.daysToReview - 1
            return card
        }
        
    }
    
    func saveConfiguredPack() {
        
        MCHandlers.saveLocalPacks(self.allPacks)
        
    }
    
}

