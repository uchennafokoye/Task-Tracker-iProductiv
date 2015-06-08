//
//  AppDelegate.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/3/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var savedtaskMgr : TaskManager?
    var savedDate : NSDate?
    var savediProductivList : TodoList?
    var savedSettings : settings?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        registerNotifications()
            
        // Override point for customization after application launch.
        return true
    }
    
    
    func registerNotifications() {
        //Complete Action
        let completeAction = UIMutableUserNotificationAction()
        completeAction.identifier = "COMPLETE_ACTION"
        completeAction.title = "Completed"
        completeAction.activationMode = UIUserNotificationActivationMode.Background
        completeAction.authenticationRequired = false
        completeAction.destructive = false
        
        
        
        //Snooze Action
        let snoozeAction = UIMutableUserNotificationAction()
        snoozeAction.identifier = "SNOOZE_ACTION"
        snoozeAction.title = "Snooze"
        snoozeAction.activationMode = UIUserNotificationActivationMode.Background
        snoozeAction.authenticationRequired = false
        snoozeAction.destructive = false
        
        
        
        
        //Cancel Notifications Action
        let deleteAction = UIMutableUserNotificationAction()
        deleteAction.identifier = "DELETE_ACTION"
        deleteAction.title = "Cancel Future Notifications"
        deleteAction.activationMode = UIUserNotificationActivationMode.Background
        deleteAction.authenticationRequired = false
        deleteAction.destructive = true
        
        //Category
        
        let notificationCategory = UIMutableUserNotificationCategory()
        notificationCategory.identifier = "NOTIFICATION_CATEGORY"
        
        notificationCategory.setActions([completeAction, snoozeAction, deleteAction], forContext: .Default)
        
        notificationCategory.setActions([completeAction, snoozeAction, deleteAction], forContext: .Minimal)
        
        
        
        let types = UIUserNotificationType.Alert | UIUserNotificationType.Sound
        
        let settings = UIUserNotificationSettings(forTypes: types, categories: NSSet(object: notificationCategory))
        
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert | .Badge | .Sound, categories: nil))

    }
    
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        var savedList = savediProductivList!
        if notification.category == "NOTIFICATION_CATEGORY" {
            
            //let action : Actions = Actions.fromRaw(identifier!)!
            //println(identifier);
            
            switch identifier! {
                
                case "COMPLETE_ACTION":
                    savedList.todoItems.removeAtIndex(0)
                    if (savedList.todoItems.count > 0) {
                        savedList.scheduleNextBatch()
                    }
                break
                
                case "SNOOZE_ACTION":
                    savedList.rescheduleNotif()
                break

                
                case "DELETE_ACTION":
                    savedList.deleteItems()
                    savedList.deleteNotifications()
                break
                
            default:
                break
                
            
            }
            
            
            completionHandler()
            
        }
        
        
        
        
        
        
        
    }
    /*
    // Schedule the Notifications with repeat
    func scheduleNotification() {
        //UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        // Schedule the notification ********************************************
        
            
            let notification = UILocalNotification()
            notification.alertBody = "Hey! Update your counter ;)"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.fireDate = NSDate().dateByAddingTimeInterval(30)
            println(notification)
            println("Scheduling this thing")
            notification.category = "NOTIFICATION_CATEGORY"
            notification.repeatInterval = NSCalendarUnit.CalendarUnitMinute
            
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        println("I'm here")
        scheduleNotification()
    }
    */
    
    
    

    func applicationWillResignActive(application: UIApplication) {
        
        savedtaskMgr = taskMgr
        savedDate = date
        savediProductivList = iProductivList
        savedSettings = mysettings
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

