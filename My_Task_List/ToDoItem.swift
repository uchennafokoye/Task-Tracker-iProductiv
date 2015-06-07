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
    var end: NSDate
    var UUID: String
    
    init(start: NSDate, end:NSDate, title: String, UUID: String){
        self.start = start
        self.end = end
        self.title = title
        self.UUID = UUID
    }
    
    var isOverdue: Bool {
        return (NSDate().compare(self.end) == NSComparisonResult.OrderedDescending)
    }
    
    
}


class TodoList {
    
    class var sharedInstance : TodoList {
        struct Static {
            static let instance : TodoList = TodoList()
        }
        return Static.instance
    }
    
    
    private let ITEMS_KEY = "todoItems"
    
    func addItem(item: TodoItem) {
        var todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary()
        
        todoDictionary[item.UUID] = ["end": item.end, "title": item.title, "UUID": item.UUID]
        NSUserDefaults.standardUserDefaults().setObject(todoDictionary, forKey: ITEMS_KEY)
        
        var notification = UILocalNotification()
        notification.alertBody = "Todo Item \"\(item.title)\" is Overdue"
        notification.alertAction = "open"
        notification.fireDate = item.end
        println("This is the begining: \(item.start)")
        println("This is the end: \(item.end)")
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["UUID": item.UUID,]
        notification.category = "iProductiv Schedule"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
        
        
        
    }
    
    
    func addItemForStart(item: TodoItem) {
        var todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary()
        
        todoDictionary[item.UUID] = ["start": item.start, "title": item.title, "UUID": item.UUID]
        NSUserDefaults.standardUserDefaults().setObject(todoDictionary, forKey: ITEMS_KEY)
        
        var notification = UILocalNotification()
        notification.alertBody = "Todo Item \"\(item.title)\" is About to Begin"
        notification.alertAction = "open"
        notification.fireDate = item.start
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["UUID": item.UUID,]
        notification.category = "iProductiv Schedule"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
    
        
    }
    
    
    
}
