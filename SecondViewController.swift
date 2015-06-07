//
//  SecondViewController.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/5/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit


class settings {
    
    var snoozeNo : Int
    var reminderSegment: Int
    var inspirationSegment: Int
    
    init(snooze: Int, reminder: Int, inspiration: Int) {
        self.snoozeNo = snooze
        self.reminderSegment = reminder
        self.inspirationSegment = inspiration
    }
   
    
}

var mysettings = settings(snooze: 5, reminder: 2, inspiration: 2)


class SecondViewController: UITableViewController {

    @IBOutlet weak var snoozeCell: UITableViewCell!
    @IBOutlet weak var reminderCell: UITableViewCell!
    @IBOutlet weak var inspirationCell: UITableViewCell!
    
    @IBOutlet var preferenceTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        snoozeCell.detailTextLabel!.text = "5 minutes"
        reminderCell.detailTextLabel!.text = "Start & End"
        inspirationCell.detailTextLabel!.text = "Art & Quotes"
        
        preferenceTbl.allowsSelection = false;

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        var snooze = mysettings.snoozeNo
        var reminder = mysettings.reminderSegment
        var inspiration = mysettings.inspirationSegment
        
        
        snoozeCell.detailTextLabel!.text = "\(snooze)" + " minutes"
        
        switch reminder {
            
        case 0:
            reminderCell.detailTextLabel!.text = "Start of Task"
            break
            
        case 1:
            reminderCell.detailTextLabel!.text = "End of Task"

            break
            
        case 2:
            reminderCell.detailTextLabel!.text = "Start & End"
            break
            
        default:
            break
        }
        
        
        switch inspiration{
            
        case 0:
            inspirationCell.detailTextLabel!.text = "Art"
            break
            
        case 1:
            inspirationCell.detailTextLabel!.text = "Quotes"
            
            break
            
        case 2:
            inspirationCell.detailTextLabel!.text = "Arts & Quotes"
            break
            
        default:
            break
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
