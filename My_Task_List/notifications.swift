//
//  notifications.swift
//  My_Task_List
//
//  Created by Student on 6/8/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import Foundation
import UIKit

var notifMgr: notifManager = notifManager()
struct notif {
    var name : String
    var tofire : NSDate
    var notification : UILocalNotification
    
}

class notifManager: NSObject {
    
    var notifications = [UILocalNotification]()

   
    func deleteNotif(index: Int) {
        UIApplication.sharedApplication().cancelLocalNotification(notifications[index])
        updateNotifMgr()
    }
    
    func updateNotifMgr() {
        notifMgr.notifications = []
        var scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        var notification : UILocalNotification?
        var error : NSError?
        var jsonTranslated = [AnyObject]()
        for (var i = 0; i < scheduledNotifications.count; i++) {
            notification = scheduledNotifications[0] as? UILocalNotification
            notifMgr.notifications.append(notification!)
            
        }
        
        
    }
    
    
}