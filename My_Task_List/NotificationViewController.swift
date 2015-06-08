//
//  NotificationViewController.swift
//  My_Task_List
//
//  Created by Student on 6/8/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit

class NotificationViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    @IBOutlet weak var notifTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifTbl.delegate = self
        notifTbl.dataSource = self
        notifMgr.updateNotifMgr()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        notifMgr.updateNotifMgr()
        println(notifMgr.notifications.count)

        notifTbl.reloadData()
    }
    
    
   
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "notif")
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "notif", forIndexPath: indexPath) as UITableViewCell
        
        
        
        var formatter = NSDateFormatter()
        println(formatter.stringFromDate(notifMgr.notifications[indexPath.row].fireDate!))
        cell.textLabel?.text = formatter.stringFromDate(notifMgr.notifications[indexPath.row].fireDate!)
        
        cell.textLabel?.font = UIFont(name: "Avenir Next Regular", size: 15.0)
        /*
        cell.detailTextLabel?.font = UIFont(name: "Avenir Next Ultra Light", size: 15.0)
*/
        
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    // UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifMgr.notifications.count
    }
    
    
    // UITableViewDelete
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            notifMgr.deleteNotif(indexPath.row)
            notifTbl.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        
        
        
    }
    
    /*
    @IBAction func swipeHandler(sender: UISwipeGestureRecognizer) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
*/
    
    @IBAction func onBackBtn(sender: UIButton) {
          self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }



}
