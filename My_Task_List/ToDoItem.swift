//
//  ToDoItem.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/6/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import Foundation
import UIKit

struct TodoItem {
    
    var title: String
    var start: NSDate
    var dur: NSTimeInterval
    var UUID: String
    var timeformat : Int
    
    init(start: NSDate, dur:NSTimeInterval, title: String, UUID: String, timeformat: Int){
        self.start = start
        self.dur = dur
        self.title = title
        self.UUID = UUID
        self.timeformat = timeformat
    }
   
    
}

var savediProductivList : TodoList?
var iProductivList = savediProductivList!

class TodoList {
    
    var todoItems = [TodoItem]()
 
    
    
    func scheduleNotif(item: TodoItem, alertBody: String, firedate: NSDate) {
        
        var notification = UILocalNotification()
        notification.category = "NOTIFICATION_CATEGORY"
        
        notification.alertBody = " \(alertBody)"
        notification.alertAction = "open"
        notification.fireDate = firedate
        
        println(notification)
        
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["UUID": item.UUID,]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
    }
    
    
    
    
    func scheduleNextBatch() {
        var item = todoItems[0]
        var alert = "Time to get started with \(item.title)"
        
        var start = item.start.dateByAddingTimeInterval(30)
        var end = item.start.dateByAddingTimeInterval(item.dur + 30)
        
        scheduleNotif(item, alertBody: alert, firedate: start)
        
        alert = "You should be done with \(item.title)"
        scheduleNotif(item, alertBody: alert, firedate: end)
    }
    
    func deleteNotifications () {
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        
    }
    
    func rescheduleNotif() {
        
        var item = todoItems[0]
        var timeInterval = Double(mysettings.snoozeNo * 60)
        item.start = NSDate().dateByAddingTimeInterval(timeInterval)
        deleteNotifications()
        scheduleNextBatch()
        
    }
    
    
    func allItems() -> [TodoItem]{
    return todoItems;
    }
    
    func deleteItems() {
        todoItems = []
    }
    
    
    
    func convertIProductivListToTaskMgr() -> TaskManager{
        
        var myMgr = TaskManager()
        
        for (var i = 0; i < todoItems.count; i++){
            
            var item = todoItems[i]
            var name = item.title
            var dur =  Int((item.timeformat == 0) ? (item.dur / 60) : (item.dur / 60 / 60))
            var timeformat = item.timeformat
            
            myMgr.tasks.append(task(name: name, dur: dur, timeformat: timeformat))
            
            
        }
        
        
        return myMgr
    }
    
    
    
}
