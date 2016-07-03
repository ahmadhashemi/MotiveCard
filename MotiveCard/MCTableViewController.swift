//
//  MCTableViewController.swift
//  MotiveCard
//
//  Created by Mohamadreza on 4/14/1395 AP.
//  Copyright © 1395 Ahmad. All rights reserved.
//

import UIKit
import CoreData


class MCTableViewController: UITableViewController {

    var List : Array<AnyObject> = []
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : MCTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! MCTableViewCell
        let data : NSManagedObject = List[indexPath.row] as! NSManagedObject
        cell.Label.text = data.valueForKey("word") as? String
        
        return cell
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let AppDell = UIApplication.sharedApplication().delegate as! AppDelegate
        let Context : NSManagedObjectContext = AppDell.managedObject
        let request = NSFetchRequest(entityName: "Word")
        
        List = try! Context.executeFetchRequest(request)
        tableView.reloadData()
        
    }
    
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let AppDell : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let Context : NSManagedObjectContext = AppDell.managedObjectContext
        if editingStyle == UITableViewCellEditingStyle.Delete {
            Context.deleteObject(List[indexPath.row] as! NSManagedObject)
            List.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        
        do {
            try Context.save()
        }catch {
            print("Error Saving")
            abort()
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "UpdateCell" {
            let selectedItem : NSManagedObject = List[self.tableView.indexPathForSelectedRow!.row] as! NSManagedObject
            let ViewCon : AddViewController = segue.destinationViewController as! MCAddViewController
            ViewCon.word = selectedItem.valueForKey("word") as! String
            
            
            ViewCon.existingItem = selectedItem
            
            
        }
        
        
        
        
    }

}
