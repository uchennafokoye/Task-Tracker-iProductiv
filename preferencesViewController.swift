//
//  preferencesViewController.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/5/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit

class preferencesViewController: UIViewController  {
    
    @IBOutlet weak var snoozeInput: UITextField!
    
    @IBOutlet weak var reminderControl: UISegmentedControl!
    
    @IBOutlet weak var inspirationControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snoozeInput!.text = "\(mysettings.snoozeNo)"
        reminderControl.selectedSegmentIndex = mysettings.reminderSegment
        inspirationControl.selectedSegmentIndex = mysettings.inspirationSegment
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func save(sender: UIButton) {
        
        if let snooze = snoozeInput.text.toInt() {
            
            mysettings.snoozeNo = snooze
            mysettings.inspirationSegment = reminderControl.selectedSegmentIndex
            mysettings.reminderSegment = inspirationControl.selectedSegmentIndex
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            
            let title = "Incorrect Snooze Input"
            let message = "Snooze has to be a number"
            let alertController = UIAlertController(title: "Cancel", message: message, preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
            return
            
            
        }
    }
    
    @IBAction func cancel(sender: UIButton) {
        
        let title = "Confirm Cancel"
        let message = "Are you sure you want to cancel"
        let alertController = UIAlertController(title: "Cancel", message: message, preferredStyle: .Alert)
        
        let ReturnAction = UIAlertAction(title: "Return", style: .Default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(ReturnAction)
        
        
        presentViewController(alertController, animated: true, completion: nil)
        
        return

        
    }
       /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let target = segue.destinationViewController as? FirstViewController {
            target.dateLabel.text = "\(date)"
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

*/
}
