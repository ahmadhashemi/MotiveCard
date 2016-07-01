//
//  MCCard.swift
//  MotiveCard
//
//  Created by Ahmad on 7/2/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCCard: NSObject, NSCoding {
    
    var word: NSString = ""
    var definition: NSString = ""
    var box: NSInteger = 1
    var daysToReview: NSInteger = 1
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.word, forKey: "word")
        aCoder.encodeObject(self.definition, forKey: "definition")
        aCoder.encodeInteger(self.box, forKey: "box")
        aCoder.encodeInteger(self.daysToReview, forKey: "daysToReview")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.word = aDecoder.decodeObjectForKey("word") as! NSString
        self.definition = aDecoder.decodeObjectForKey("definition") as! NSString
        self.box = aDecoder.decodeIntegerForKey("box") as NSInteger
        self.daysToReview = aDecoder.decodeIntegerForKey("daysToReview") as NSInteger
        
    }
    
}