//
//  AppDelegate.swift
//  MotiveCard
//
//  Created by Ahmad on 6/29/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.configureAppearance()
        
        Parse.initializeWithConfiguration(ParseClientConfiguration(block: { (config) in
            
            config.applicationId = "ZCDx0cqm6Wu4JJ7hWFJXqErhaA0qpka11Daxgd5n"
            config.clientKey = " "
            config.server = "https://back.ahmadhashemi.com/parse"
            
        }))
        
        return true
    }
    
    func configureAppearance() {
        
        let navBarColor = UIColor(red:0.074,  green:0.078,  blue:0.083, alpha:1)
        let redColor = UIColor(red:0.951,  green:0.289,  blue:0.063, alpha:1)
        let pinkColor = UIColor(red:0.698,  green:0.135,  blue:0.330, alpha:1)
        
        let tabBarFont = UIFont(name: "IRANSans", size: 10)
        let navBarFont = UIFont(name: "IRANSans", size: 20)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:tabBarFont!], forState: .Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:tabBarFont!], forState: .Selected)
        UITabBar.appearance().tintColor =  redColor // UIColor.whiteColor()
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName:navBarFont!], forState: .Normal)
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:navBarFont!,NSForegroundColorAttributeName:redColor]
        
        UINavigationBar.appearance().tintColor = pinkColor
        UINavigationBar.appearance().barTintColor = navBarColor
        UITabBar.appearance().barTintColor = navBarColor
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

