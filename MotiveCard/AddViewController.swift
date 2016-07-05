//
//  AddViewController.swift
//  MotiveCard
//
//  Created by Mohamadreza on 4/15/1395 AP.
//  Copyright © 1395 Ahmad. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    var words : Array<String> = []
    var PackName : String = ""
    var Moviename : String = ""
    //var index : Int = 0
    
    
    @IBOutlet weak var PackageName: UITextField!
    
    
    @IBOutlet weak var MovieName: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    /*    override func viewDidAppear(animated: Bool) {
    tableView.reloadData()
    print("This is array : \(self.words)")
    }*/
    
    @IBAction func AddButton(sender: AnyObject) {
    
    
        self.PackName = self.PackageName.text!
        self.Moviename = self.MovieName.text!
        
        let alert = UIAlertController(title: "اضافه کردن لغت جدید", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        var inputTextField: UITextField?
        
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "لغت خود را وارد کنید"
            inputTextField = textField
        })
        alert.addAction(UIAlertAction(title: "اضافه کردن", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            if (inputTextField?.text! != ""){
                
                self.words.insert(inputTextField!.text!, atIndex: 0)
                //   let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                //     self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                self.tableView.reloadData()
            } else {
                
            }
            
        }))
        alert.addAction(UIAlertAction(title: "لغو کردن", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func DoneButton(sender: AnyObject) {
        
        print("The Package Name is \(self.PackName)")
        print("The Movie Name is \(self.Moviename)")
        print("The Words are \(self.words)")}
    
    
    }




extension AddViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! AddTableViewCell
        let data = words[indexPath.row]
        cell.Label.text = data
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            words.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    

}
