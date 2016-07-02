//
//  MCPack.swift
//  MotiveCard
//
//  Created by Ahmad on 7/2/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit

class MCPack: NSObject {
    
    var packName: NSString? = ""
    var movieName: NSString? = ""
    
    var subtitlePath: NSString? = ""
    var movieURL: NSURL? = NSURL()
    
    var words: [MCCard] = []
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.packName, forKey: "packName")
        aCoder.encodeObject(self.movieName, forKey: "movieName")
        
        aCoder.encodeObject(self.subtitlePath, forKey: "subtitlePath")
        aCoder.encodeObject(self.movieURL, forKey: "movieURL")
        
        aCoder.encodeObject(self.words, forKey: "words")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.packName = aDecoder.decodeObjectForKey("packName") as? NSString
        self.movieName = aDecoder.decodeObjectForKey("movieName") as? NSString
        
        self.subtitlePath = aDecoder.decodeObjectForKey("subtitlePath") as? NSString
        self.movieURL = aDecoder.decodeObjectForKey("movieURL") as? NSURL
        
        self.words = aDecoder.decodeObjectForKey("words") as! [MCCard]
        
    }
    
    override init() {
        
    }

}
