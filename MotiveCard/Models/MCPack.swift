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
    
    var words: [MCCard] = []
    
    var subtitleURL: NSURL? = NSURL() // missing
    var movieURL: NSURL? = NSURL() // missing
    var imageURL: NSURL? = NSURL() // missing
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(self.packName, forKey: "packName")
        aCoder.encodeObject(self.movieName, forKey: "movieName")
        
        aCoder.encodeObject(self.subtitleURL, forKey: "subtitleURL")
        aCoder.encodeObject(self.movieURL, forKey: "movieURL")
        aCoder.encodeObject(self.imageURL, forKey: "imageURL")
        
        aCoder.encodeObject(self.words, forKey: "words")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.packName = aDecoder.decodeObjectForKey("packName") as? NSString
        self.movieName = aDecoder.decodeObjectForKey("movieName") as? NSString
        
        self.subtitleURL = aDecoder.decodeObjectForKey("subtitleURL") as? NSURL
        self.movieURL = aDecoder.decodeObjectForKey("movieURL") as? NSURL
        self.imageURL = aDecoder.decodeObjectForKey("imageURL") as? NSURL
        
        self.words = aDecoder.decodeObjectForKey("words") as! [MCCard]
        
    }
    
    override init() {
        
    }

}
