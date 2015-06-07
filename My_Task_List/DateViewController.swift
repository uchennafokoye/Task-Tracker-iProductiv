//
//  DateViewController.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/4/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit

var date = NSDate()


class DateViewController: UIViewController {

    @IBOutlet weak var segmentDates: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var selectBtn: UIButton!
    
    
    @IBAction func optionSelected(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            
            datePicker.datePickerMode = .Time
            
        } else if sender.selectedSegmentIndex == 1 {
            
            datePicker.datePickerMode = .DateAndTime
            
        }
    }
    
    @IBAction func datePicked(sender: UIButton) {
        
        
        
        
        let title = "Selected Time/Date"
        let message = "You have selected \(datePicker.date)"
        let alertController = UIAlertController(title: "Cancel", message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let okayAction = UIAlertAction(title: "Confirm", style: .Default) {
            action in
            date  = self.datePicker.date
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        presentViewController(alertController, animated: true, completion: nil)
        
        
    }

    
   
    @IBAction func swipeHandle(sender: UISwipeGestureRecognizer) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentDates.selectedSegmentIndex = 0
        datePicker.datePickerMode = .Time
        datePicker.minimumDate = NSDate()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let target = segue.destinationViewController as? FirstViewController {
            target.dateLabel.text = "\(date)"
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
