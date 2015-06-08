//
//  FirstViewController.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/3/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//
import darwin
import UIKit


extension NSDate {
    var localTime: String {
        return descriptionWithLocale(NSLocale.currentLocale())!
    }
    
}

var canEnableSchedBtn = true

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    
    @IBOutlet weak var schdBtn: UIButton!
    @IBOutlet weak var cancelNotifBtn: UIButton!
    
    @IBOutlet var tblTasks : UITableView!
    @IBOutlet weak var dateBtn: UIButton!
    
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        
        var schedulesExist = (UIApplication.sharedApplication().scheduledLocalNotifications.count > 0)
        
        
        let savedList = appDelegate.savediProductivList
        if let savedInstance = savedList {
            savediProductivList = savedInstance
            savedtaskMgr = savedInstance.convertIProductivListToTaskMgr()
            savedDate = savedInstance.todoItems[0].start
        } else {
            savediProductivList = TodoList()
        }
        
        let savedsettingsInstance = appDelegate.savedSettings
        if let savedInstance = savedsettingsInstance {
            
            savedSettings = savedInstance
            
            
        } else {
            savedSettings = settings(snooze: 5, reminder: 2, inspiration: 2)
        }
        
        let savedtaskInstance = appDelegate.savedtaskMgr
        if let savedInstance = savedtaskInstance {
            
            savedtaskMgr = savedInstance
            
            
        } else {
            savedtaskMgr = TaskManager()
        }
        
        
        let savedDateInstance = appDelegate.savedDate
        if let savedInstance = savedDateInstance {
            
            savedDate = savedInstance
            
            
        } else {
            savedDate = NSDate()
        }

    
    
    
        if schedulesExist {
            schdBtn.enabled = false
            cancelNotifBtn.enabled = true
        } else {
            schdBtn.enabled = canEnableSchedBtn
            cancelNotifBtn.enabled = false
            
        }
        
        
        
        tblTasks.allowsSelection = true
        tblTasks.allowsSelectionDuringEditing = true
        
        tblTasks.editing = true
        
        
        taskMgr.addTask("dance", dur: 30, timeformat: 0)
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yy hh:mm a"
        dateLabel.text = formatter.stringFromDate(date)
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    
    //Returning to view
    
    
    
    func verifyaddStatus() {
        if taskMgr.tasks.count >= 10 {
            addBtn.enabled = false
        } else {
            addBtn.enabled = true
        }
    }
    override func viewWillAppear(animated: Bool) {
               
        tblTasks.reloadData()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/yy hh:mm a"
        dateLabel.text = formatter.stringFromDate(date)
        verifyaddStatus()
       
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskMgr.tasks.count
    }
    
    
    // UITableViewDelete 
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            taskMgr.tasks.removeAtIndex(indexPath.row)
            tblTasks.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            verifyaddStatus()
            
           // tblTasks.reloadData();

        }
        
       
        
    }
    
    

    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    
    
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
        
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        swap(&taskMgr.tasks[sourceIndexPath.row], &taskMgr.tasks[destinationIndexPath.row])
        tblTasks.reloadData()

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("AddTaskViewController") as AddTaskViewController
        vc.index = indexPath.row
        vc.itemnotexist = false
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        
        var selectedSegText = "min"
        
        
        switch taskMgr.tasks[indexPath.row].timeformat{
            
        case 0:
            selectedSegText = "min"
            break
            
        case 1:
            selectedSegText = "hr"
            break
            
    
            
        default:
            break
        }

        
        cell.textLabel?.text = taskMgr.tasks[indexPath.row].name
        cell.detailTextLabel?.text = String(taskMgr.tasks[indexPath.row].dur) + " " + selectedSegText
        
        cell.textLabel?.font = UIFont(name: "Avenir Next Regular", size: 15.0)
        cell.detailTextLabel?.font = UIFont(name: "Avenir Next Ultra Light", size: 15.0)
        
        return cell
    }
    
    
    @IBAction func schedule(sender: UIButton) {
        
      
        var both = true
        var startOnly = false
        var endOnly = false
        switch mysettings.reminderSegment {
        case 0:
            both = false
            startOnly = true
            break
        case 1:
            both = false
             endOnly = true
            break
        case 2:
            both = true
            break
        default:
            both = true
            
        }
        
        var start = date
        var end : NSDate?
       //var todoItems = [TodoItem]()
        
        
        
        for (var i = 0; i < taskMgr.tasks.count; i++) {
            
            var task = taskMgr.tasks[i]
            var title = task.name
            var dur =  Double((task.timeformat == 0) ? (task.dur * 60) : (task.dur * 60 * 60))
            iProductivList.todoItems.append(TodoItem(start: start, dur: dur, title: title, UUID: NSUUID().UUIDString, timeformat: task.timeformat))
            
        }
       
        iProductivList.scheduleNextBatch(iProductivList.todoItems[0].start)
        
        
        let title = "iProductiv List Scheduled"
        let message = "All items scheduled"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel)
            {
                action in
                self.schdBtn.enabled = false
                self.cancelNotifBtn.enabled = true
                
              
                
            }

    
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        
        
        
        
    }
   
    
    @IBAction func cancelNotifications(sender: UIButton) {
        
        iProductivList.deleteItems()
        iProductivList.deleteNotifications()
        let title = "iProductiv List Canceled"
        let message = "All items canceled"
        let alertController = UIAlertController(title: "Cancel", message: message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel)
            {
                action in
                self.schdBtn.enabled = true
                self.cancelNotifBtn.enabled = false
                
                
                
        }
        
        alertController.addAction(cancelAction)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        
        
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
