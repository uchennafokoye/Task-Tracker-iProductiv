//
//  FirstViewController.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/3/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblTasks : UITableView!
    
    @IBOutlet weak var dateBtn: UIButton!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblTasks.editing = true

        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "c/dd/yy h:m a"
        dateLabel.text = formatter.stringFromDate(date)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Returning to view
    
    override func viewWillAppear(animated: Bool) {
        tblTasks.reloadData()
        var formatter = NSDateFormatter()
        formatter.dateFormat = "c/dd/yy h:m a"
        dateLabel.text = formatter.stringFromDate(date)
    }
    
    // UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskMgr.tasks.count
    }
    
    
    // UITableViewDelete 
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            taskMgr.tasks.removeAtIndex(indexPath.row)
            tblTasks.reloadData();
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
 
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        
        
        var selectedSegText = "hr"
        
        
        switch taskMgr.tasks[indexPath.row].timeformat{
            
        case 0:
            selectedSegText = "hr"
            break
            
        case 1:
            selectedSegText = "min"
            break
            
        case 2:
            selectedSegText = "sec"
            break
            
        default:
            break
        }

        
        cell.textLabel?.text = taskMgr.tasks[indexPath.row].name
        cell.detailTextLabel?.text = String(taskMgr.tasks[indexPath.row].dur) + " " + selectedSegText
        
        return cell
    }
    

    @IBAction func dateBtnClck(sender: UIButton) {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "c/dd/yy h:m a"
        println(formatter.stringFromDate(date))
       
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
