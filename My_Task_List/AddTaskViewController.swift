//
//  AddTaskViewController.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/3/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var txtTask: UITextField!
    @IBOutlet var txtDur : UITextField!
    @IBOutlet var txtTime : UISegmentedControl!
    
    @IBOutlet weak var addorEditBtn: UIButton!
    var itemnotexist = true;
    var index : Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        if !itemnotexist {
            if let i = index {
                txtTask.text = taskMgr.tasks[i].name
                txtDur.text = "\(taskMgr.tasks[i].dur)"
                txtTime.selectedSegmentIndex = taskMgr.tasks[i].timeformat
                
                addorEditBtn.titleLabel!.text = "Edit"
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAddTask_Click(sender: UIButton) {
        
        if txtTask.text == "" {
            
            let title = "Task Name Blank"
            let message = "Task Name cannot be blank"
            let alertController = UIAlertController(title: "Cancel", message: message, preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
            return
            
        } else if let dur = txtDur.text.toInt() {
            
            
            
            if itemnotexist {
                taskMgr.addTask(txtTask.text, dur: dur, timeformat: txtTime.selectedSegmentIndex)
            } else {
                
                if let i = index {
                    taskMgr.editTask(i, name: txtTask.text, dur: dur, timeformat: txtTime.selectedSegmentIndex)
                }

                
            }
            
            self.view.endEditing(true)
            txtTask.text = ""
            txtDur.text = ""
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else  {
            
            let title = "Incorrect Duration Input"
            let message = "Duration has to be a number"
            let alertController = UIAlertController(title: "Cancel", message: message, preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            presentViewController(alertController, animated: true, completion: nil)
            
            return

            
        }
        
       
    
    }
    
    
    @IBAction func swipeHandle(sender: UISwipeGestureRecognizer) {
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelBtn(sender: UIButton) {
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        return
        
        
    }
   
    
     override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)

    }
    
    
    //UI Text Field Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        return true
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
