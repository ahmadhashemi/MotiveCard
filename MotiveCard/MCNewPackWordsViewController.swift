//
//  MCNewPackWordsViewController.swift
//  MotiveCard
//
//  Created by Mohamadreza on 4/15/1395 AP.
//  Copyright © 1395 Ahmad. All rights reserved.
//

import UIKit
import Parse

class MCNewPackWordsViewController: UIViewController {
    
    var newOnlinePack = MCOnlinePack()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.editing = true
        self.tableView.allowsSelectionDuringEditing = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Pack-Add"), style: .Plain, target: self, action: Selector("addButtonTapped:"))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: Selector("doneButtonTapped:"))
        
        self.tableView.separatorColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
        
    }
    
}

extension MCNewPackWordsViewController {
    
    func addButtonTapped(sender: AnyObject) {
        
        let alert = UIAlertController(title: "اضافه کردن لغت جدید", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "لغت مورد نظر را وارد کنید"
            textField.textAlignment = .Center
        })
        
        alert.addAction(UIAlertAction(title: "اضافه کردن", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            let wordTextField = alert.textFields![0]
            
            guard wordTextField.text != "" else {
                return
            }
            
            let dublicates = self.newOnlinePack.words.filter({ (word) -> Bool in
                return word == wordTextField.text
            })
            
            if dublicates.count != 0 {
                print("dublicate word")
                return
            }
            
            self.newOnlinePack.words.insert(wordTextField.text!, atIndex: 0)
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Fade)
            
        }))
        
        alert.addAction(UIAlertAction(title: "بازگشت", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    func doneButtonTapped(sender: AnyObject) {
        
        if self.newOnlinePack.words.count == 0 {
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
        
        let title = "بسته جدید"
        let message = "آیا قصد ارسال بسته جدید به سرور و ذخیره‌سازی آنلاین آن را دارید؟"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "بله", style: .Default, handler: { (action) in
            
            self.makeNewOnlinePack(withName: self.newOnlinePack.packName, movieName: self.newOnlinePack.movieName, andWords: self.newOnlinePack.words as NSArray)
            
        }))
        
        alert.addAction(UIAlertAction(title: "خیر", style: .Cancel, handler : { (action) in
            
            self.navigationController?.popViewControllerAnimated(true)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
}

extension MCNewPackWordsViewController {
    
    func makeNewOnlinePack(withName name: NSString, movieName: NSString, andWords words: NSArray) {
        
        let newOnlinePack = PFObject(className: "Packs")
        
        newOnlinePack.setObject(name, forKey: "PackName")
        newOnlinePack.setObject(movieName, forKey: "MovieName")
        newOnlinePack.setObject(words, forKey: "Words")
        
        newOnlinePack.saveInBackgroundWithBlock { (saved, error) in
            
            if !saved {
                print(error?.localizedDescription)
            }
            
            self.navigationController?.popViewControllerAnimated(true)
            
        }
        
    }
    
}

extension MCNewPackWordsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newOnlinePack.words.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell?.textLabel!.text = self.newOnlinePack.words[indexPath.row] as String
        
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            self.newOnlinePack.words.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let word = self.newOnlinePack.words[indexPath.row]
        
        let message = "ویرایش لغت"
        let alert = UIAlertController(title: "", message: message, preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textField) in
            textField.textAlignment = .Center
            textField.text = word as String
        }
        
        alert.addAction(UIAlertAction(title: "ذخیره", style: .Default, handler: { (action) in
            
            let newWord = alert.textFields![0].text
            
            self.newOnlinePack.words.removeAtIndex(indexPath.row)
            
            if newWord == "" {
                
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            } else {
                
                self.newOnlinePack.words.insert(newWord!, atIndex: indexPath.row)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "انصراف", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let moveWord = self.newOnlinePack.words[sourceIndexPath.row]
        self.newOnlinePack.words.removeAtIndex(sourceIndexPath.row)
        self.newOnlinePack.words.insert(moveWord, atIndex: destinationIndexPath.row)
        
    }

}
