//
//  MCPlayerViewController.swift
//  MotiveCard
//
//  Created by Mohamadreza on 4/24/1395 AP.
//  Copyright © 1395 Ahmad. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MCPlayerViewController: UIViewController {
    
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
        let delay = 10 as! Double //integer ( 60 seconds for our app )
        //let endTime = beginTime.seconds + delay
        
        
        let path = NSBundle.mainBundle().pathForResource("video", ofType:"mov") // Local path
        
        //let player = AVPlayer(URL: NSURL(string: "http://as7.asset.aparat.com/aparat-video/ a_lckl511hkinnkplml2l0598n3l71588l4o9832452418-058z__a87c2.mp4")!) // Online Player
        
        
        let player = AVPlayer(URL: NSURL(fileURLWithPath: path!)) // Local Player
        
        
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
