//
//  MCHandlers.swift
//  MotiveCard
//
//  Created by Ahmad on 7/4/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit
import Parse

class MCHandlers: NSObject {
    
    static var localPacksPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/packs"
    static var localHistoryPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] + "/history"
    
}

extension MCHandlers {
    
    static func getLocalPacks() -> [MCPack] {
        
        let localPacks = NSKeyedUnarchiver.unarchiveObjectWithFile(localPacksPath) as? [MCPack]
        
        if localPacks == nil {
            return []
        }
        
        return localPacks!
    }
    
    static func addNewPackToLocalPacks(pack: MCPack) {
        
        var localPacks = MCHandlers.getLocalPacks()
        localPacks.append(pack)
        MCHandlers.saveLocalPacks(localPacks)
        
    }
    
    static func removeLocalPack(pack: MCPack) { // missing
        
    }
    
    static func saveLocalPacks(packs: [MCPack]) {
        
        NSKeyedArchiver.archiveRootObject(packs, toFile: localPacksPath)
        
    }
    
}

extension MCHandlers {
    
    static func getLocalHistory() -> [MCHistory] {
        
        let localHistory = NSKeyedUnarchiver.unarchiveObjectWithFile(localHistoryPath) as? [MCHistory]
        
        if localHistory == nil {
            return []
        }
        
        return localHistory!
        
    }
    
    static func addNewHistoryToLocalHistory(history: MCHistory) {
        
        var localHistory = MCHandlers.getLocalHistory()
        localHistory.append(history)
        MCHandlers.saveLocalHistory(localHistory)
        
    }
    
    static func saveLocalHistory(history: [MCHistory]) {
        
        NSKeyedArchiver.archiveRootObject(history, toFile: localHistoryPath)
        
    }
    
}

extension MCHandlers {
    
    static func makeLocalPackWithOnlinePack(online: MCOnlinePack) -> MCPack {
        
        let newPack = MCPack()
        
        newPack.packName = online.packName
        newPack.movieName = online.movieName
        
        for word in online.words {
            
            let newCard = MCCard()
            newCard.word = word
            
            newPack.words.append(newCard)
            
        }
        
        return newPack
        
    }
    
}

extension MCHandlers {
    
    static func search(forWord word: String?, inMovie movie: String?) {
        
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
