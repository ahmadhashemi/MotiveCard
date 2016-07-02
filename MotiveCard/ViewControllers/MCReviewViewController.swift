//
//  MCReviewViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/2/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit
import Haneke

class MCReviewViewController: UIViewController {

    @IBOutlet weak var pageView: UIView!
    
    var selectedPack = MCPack()
    var cardsToReview: [MCCard] = []
    
    var pageVC = UIPageViewController()
    var selectedCardIndex = 0
    
    var correctCount: NSInteger = 0
    var wrongCount: NSInteger = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.findCardsToReview()
        self.configurePageView()
        
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
            self.commonTaks()
            
        }));
        
        alert.addAction(UIAlertAction(title: "حدس نزدم", style: .Default, handler: { (action) in
            
            self.guessedDefinitionForCard(selectedCard, correct: false)
            self.commonTaks()
            
        }));
        
        alert.addAction(UIAlertAction(title: "بازگشت", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func commonTaks() {
        
        selectedCardIndex = selectedCardIndex + 1
        self.goToNextCardViewController()
        
    }
    
    @IBAction func movieButtonTapped(sender: UIButton) {
        
        let reviewCard = cardsToReview[selectedCardIndex]
        
        self.search(forWord: reviewCard.word as? String, inMovie: self.selectedPack.movieName as? String)
        
    }
    
}

extension MCReviewViewController {
    
    func search(forWord word: String?, inMovie movie: String?) {
        
        if word == nil { return }
        if movie == nil { return }
        
        let subtitlePath = NSBundle.mainBundle().pathForResource(movie, ofType: "srt")
        
        if subtitlePath == nil { return }
        
        let subtitleString = try? NSString(contentsOfFile: subtitlePath!, encoding: 1)
        
        let allComponents = (subtitleString?.componentsSeparatedByString("\r\n\r\n"))! as [String]
        let containedComponents = allComponents.filter({ (component) -> Bool in
            component.containsString(word!)
        })
        
        if containedComponents.count == 0 {
            return
        }
        
        let component = containedComponents[0]
        let timeLine = component.componentsSeparatedByString("\r\n")[1]
        let beginTime = timeLine.componentsSeparatedByString(" --> ")[0]
        
        print(beginTime)
        
        
    }
    
}

extension MCReviewViewController {
    
    func findCardsToReview() {
        
        cardsToReview = selectedPack.words.filter({ (card) -> Bool in
            let result = card.daysToReview == 1 && card.box < 7
            return result
        })
        
        
    }
    
    func guessedDefinitionForCard(card: MCCard, correct: Bool) {
        
        if correct {
            
            card.box = card.box + 1
            card.daysToReview = card.box
            
            correctCount = correctCount + 1
            
        } else {
            
            card.box = 1
            card.daysToReview = 1
            
            wrongCount = wrongCount + 1
            
        }
        
    }
    
    ////////
    
    func reviewHasNoCards() {
        
        
        
    }
    
    ////////
    
    func reviewFinished() {
        
        self.configureNotReviewedCards()
        self.saveConfiguredPack()
        self.moveViewToFinishStatus()
        
    }
    
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
        
        //NSKeyedArchiver.archiveRootObject(newPack, toFile: "/Users/ahmad/Desktop/packData")
        
    }
    
    func moveViewToFinishStatus() {
        
        let resultVC = self.storyboard?.instantiateViewControllerWithIdentifier("ResultVC") as! MCResultViewController
        
        resultVC.corectCount = correctCount
        resultVC.wrongCount = wrongCount
        
        resultVC.modalTransitionStyle = .FlipHorizontal
        
        self.navigationController?.presentViewController(resultVC, animated: true) {
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
}

extension MCReviewViewController {
    
    func goToNextCardViewController() {
        
        let cardVC = self.storyboard?.instantiateViewControllerWithIdentifier("CardVC") as! MCCardViewController
        
        if selectedCardIndex == cardsToReview.count { // review is finished
            
            if cardsToReview.count == 0 {
                
                self.reviewHasNoCards()
                
            } else {
                
                self.reviewFinished()
                
            }
            
            return
        }
        
        cardVC.selectedCard = cardsToReview[selectedCardIndex]
        cardVC.cardIndex = cardsToReview.count - selectedCardIndex
        
        pageVC.setViewControllers([cardVC], direction: .Forward, animated: true, completion: nil)
        
    }
    
}
