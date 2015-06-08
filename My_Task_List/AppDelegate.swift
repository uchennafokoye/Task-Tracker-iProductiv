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

    
    var savedtaskMgr : TaskManager?
    var savedDate : NSDate?
    var savediProductivList : TodoList?
    var savedSettings : settings?
    
    enum Actions:String{
        case complete = "COMPLETE_ACTION"
        case snooze = "SNOOZE_ACTION"
        case delete = "DELETE_ACTION"
    }
    
    var categoryID:String {
        get{
            return "NOTIFICATION_CATEGORY"
        }
    }
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Todo: Check if settings are already registered
        registerNotification()
        
        return true
    }
    
    // Register notification settings
    func registerNotification() {
        
        // 1. Create the actions **************************************************
        //Complete Action
        
        let completeAction = UIMutableUserNotificationAction()
        completeAction.identifier = Actions.complete.rawValue
        completeAction.title = "Completed"
        completeAction.activationMode = UIUserNotificationActivationMode.Background
        completeAction.authenticationRequired = false
        completeAction.destructive = false
        
        //Snooze Action
        let snoozeAction = UIMutableUserNotificationAction()
        snoozeAction.identifier = Actions.snooze.rawValue
        snoozeAction.title = "Snooze"
        snoozeAction.activationMode = UIUserNotificationActivationMode.Background
        snoozeAction.authenticationRequired = false
        snoozeAction.destructive = false
        
        

        // reset Action
        let deleteAction = UIMutableUserNotificationAction()
        deleteAction.identifier = Actions.delete.rawValue
        deleteAction.title = "Reset"
        deleteAction.activationMode = UIUserNotificationActivationMode.Background
        // NOT USED deleteAction.authenticationRequired = false
        deleteAction.destructive = true
        
        
        // 2. Create the category ***********************************************
        
        // Category

        let notificationCategory = UIMutableUserNotificationCategory()

        notificationCategory.identifier = categoryID
        
        // A. Set actions for the default context
        notificationCategory.setActions([completeAction, snoozeAction, deleteAction], forContext: UIUserNotificationActionContext.Default)
        
        // B. Set actions for the minimal context
        notificationCategory.setActions([completeAction, snoozeAction], forContext: UIUserNotificationActionContext.Minimal)

        
        
        // 3. Notification Registration *****************************************
        
        let types = UIUserNotificationType.Alert | UIUserNotificationType.Sound
        let settings = UIUserNotificationSettings(forTypes: types, categories: NSSet(object: notificationCategory))
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    /*
    // Schedule the Notifications with repeat
    func scheduleNotification() {
        //UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        // Schedule the notification ********************************************
        
        let notification = UILocalNotification()
        notification.alertBody = "Hey! Update your counter ;)"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.fireDate = NSDate().dateByAddingTimeInterval(10)
        notification.category = categoryID
        notification.repeatInterval = NSCalendarUnit.CalendarUnitMinute
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }

    
    
    // MARK: Application Delegate
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        scheduleNotification()
    }
    */
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        var savedList = savediProductivList!
        if notification.category == "NOTIFICATION_CATEGORY" {
            
            //let action : Actions = Actions.fromRaw(identifier!)!
            //println(identifier);
            
            let action:Actions = Actions(rawValue: identifier!)!

            switch action {
                
                
                case Actions.complete:
                    savedList.deleteAndScheduleNext()
                break
                
                case Actions.snooze:
                    savedList.rescheduleNotif()
                break

                
                case Actions.delete:
                    savedList.deleteItems()
                    savedList.deleteNotifications()
                break
                
            default:
                break
                
            
            }
            
            
            completionHandler()
            
        }
        
    }
    


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

