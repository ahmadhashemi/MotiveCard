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
    
    static func addNewPackToLocalPacks(pack: MCPack) {
        
        var localPacks = MCHandlers.getLocalPacks()
        localPacks.append(pack)
        MCHandlers.saveLocalPack(localPacks)
        
    }
    
    static func removeLocalPack(pack: MCPack) {
        
//        var localPacks = MCHandlers.getLocalPacks()
//        var packsToRemove = localPacks.filter { (eachPack) -> Bool in
//            return (eachPack.packName?.isEqualToString(pack.packName as! String))!
//        }
//        var indexesToRemove = packsToRemove.map { (eachPack) -> [Integer] in
//            return localPacks.indexOf(eachPack)
//        }
//        
//        for eachRemove in packsToRemove {
//            localPacks.
//        }
//        
//        MCHandlers.saveLocalPack(localPacks)
        
    }
    
    static func getLocalPacks() -> [MCPack] {
        
        let localPacks = NSKeyedUnarchiver.unarchiveObjectWithFile(localPacksPath) as! [MCPack]
        return localPacks
    }
    
    static func saveLocalPack(packs: [MCPack]) {
        
        NSKeyedArchiver.archiveRootObject(packs, toFile: localPacksPath)
        
    }
    
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
    
    static func tempFunctionToMakeDataSource() {
        
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
        
        NSKeyedArchiver.archiveRootObject([newPack], toFile: localPacksPath)
        
    }
    
}
