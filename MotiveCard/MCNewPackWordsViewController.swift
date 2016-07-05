//
//  MCNewPackWordsViewController.swift
//  MotiveCard
//
//  Created by Mohamadreza on 4/15/1395 AP.
//  Copyright © 1395 Ahmad. All rights reserved.
//

import UIKit

class MCNewPackWordsViewController: UIViewController {
    
    var words: Array<String> = []
    var packName: String = ""
    var movieName: String = ""
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Pack-Add"), style: .Plain, target: self, action: Selector("addButtonTapped:"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Save", style: .Done, target: self, action: Selector("saveButtonTapped:"))
        
    }
    
}

extension MCNewPackWordsViewController {
    
    func addButtonTapped(sender: AnyObject) {
        
        let alert = UIAlertController(title: "اضافه کردن لغت جدید", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "لغت خود را وارد کنید"
            textField.textAlignment = .Center
        })
        
        alert.addAction(UIAlertAction(title: "اضافه کردن", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            let wordTextField = alert.textFields![0]
            
            guard wordTextField.text != "" else {
                return
            }
            
            self.words.insert(wordTextField.text!, atIndex: 0)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
            
        }))
        
        alert.addAction(UIAlertAction(title: "بازگشت", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    func saveButtonTapped(sender: AnyObject) {
        
        print(self.movieName)
        print(self.packName)
        print(self.words)
        
    }
    
}

extension MCNewPackWordsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell?.textLabel!.text = words[indexPath.row]
        
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            words.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
    }
    
    

}
