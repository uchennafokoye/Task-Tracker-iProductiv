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
    var tofire : NSDate
    
}

class notifManager: NSObject {
    
    var notifications = [notif]()

   
    func addNotif(tofire: NSDate) {
        notifications.append(notif(tofire: tofire))
    }
    
    
    
    func updateNotifMgr() {
        notifMgr.notifications = []
        var scheduledNotifications = UIApplication.sharedApplication().scheduledLocalNotifications

        for (var i = 0; i < scheduledNotifications.count; i++) {
            var firedate = scheduledNotifications[i].fireDate
            
            println(scheduledNotifications[i])
            
            notifMgr.addNotif(firedate)
            
        }
        
        
    }
    
    
}