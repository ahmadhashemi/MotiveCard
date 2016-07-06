//
//  MCHistory.swift
//  MotiveCard
//
//  Created by Ahmad on 7/6/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCHistory: NSObject, NSCoding {
    
    var pack: MCPack = MCPack()
    var correctWords: NSMutableArray = NSMutableArray()
    var wrongWords: NSMutableArray = NSMutableArray()
    var reviewDate: NSDate = NSDate()
    
    override init() {
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(pack, forKey: "pack")
        aCoder.encodeObject(correctWords, forKey: "correctWords")
        aCoder.encodeObject(wrongWords, forKey: "wrongWords")
        aCoder.encodeObject(reviewDate, forKey: "reviewDate")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.pack = aDecoder.decodeObjectForKey("pack") as! MCPack
        self.correctWords = aDecoder.decodeObjectForKey("correctWords") as! NSMutableArray
        self.wrongWords = aDecoder.decodeObjectForKey("wrongWords") as! NSMutableArray
        self.reviewDate = aDecoder.decodeObjectForKey("reviewDate") as! NSDate
        
    }
    
}
