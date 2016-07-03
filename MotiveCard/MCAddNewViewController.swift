//
//  MCAddNewViewController.swift
//  MotiveCard
//
//  Created by Mohamadreza on 4/14/1395 AP.
//  Copyright © 1395 Ahmad. All rights reserved.
//

import UIKit
import CoreData

class MCAddNewViewController: UIViewController {
    
    @IBOutlet weak var Label: UILabel!
    
    @IBOutlet weak var TextField: UITextField!
    
    
    var word : String = ""
    var existingItem : NSManagedObject!
    
    
    @IBAction func SaveButton(sender: AnyObject) {
        
        let AppDell = UIApplication.sharedApplication().delegate as! AppDelegate
        let theContext : NSManagedObjectContext = AppDell.managedObjectContext
        let theEnt = NSEntityDescription.entityForName("Word", inManagedObjectContext: theContext)
        
        if (existingItem != nil){
            
            existingItem.setValue(TextField.text as String?, forKey: "word")
            
            
        }else {
            
            let newItem = MCNewWord(entity: theEnt!, insertIntoManagedObjectContext: theContext)
            
            newItem.word = TextField.text!
            
        }
        
        
        do {
            try theContext.save()
        } catch {
            print("Saving Erorr")
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        // Searching function HERE

        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if (existingItem != nil) {
            TextField.text = word
        }
    }

}
