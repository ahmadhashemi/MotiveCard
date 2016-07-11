//
//  ViewController.swift
//  TestMotive4
//
//  Created by Mohamadreza on 4/21/1395 AP.
//  Copyright © 1395 Mohamadreza. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MCVideoPlayer: UIViewController {
    
    private var firstAppear = true
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if firstAppear {
            do {
                try playVideo()
                firstAppear = false
            } catch AppError.InvalidResource(let name, let type) {
                debugPrint("Could not find resource \(name).\(type)")
            } catch {
                debugPrint("Generic error")
            }
            
        }
    }
    
    private func playVideo() throws {
        
        let beginTime = CMTimeMakeWithSeconds(66, 1)
        let delay = 10 as! Double//integer ( 60 seconds for our app )
        //let endTime = beginTime.seconds + delay
        
        
        let path = NSBundle.mainBundle().pathForResource("video", ofType:"mov") // Local path
        
        let player = AVPlayer(URL: NSURL(string: "http://as7.asset.aparat.com/aparat-video/a_ecdde6f22digjgiee3e1609g4e82699e5h0943563529-169s__39852.mp4")!) // Online Player
        
        
        // let player = AVPlayer(URL: NSURL(fileURLWithPath: path!)) // Local Player
        
        
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
}

enum AppError : ErrorType {
    case InvalidResource(String, String)
}
