//
//  TaskManager.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/3/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit

var taskMgr: TaskManager = TaskManager()

struct task {
    var name = "Un-Named"
    var dur = 20
    var timeformat = 0
}

class TaskManager: NSObject {
    
    var tasks = [task]()
    func addTask(name: String, dur: Int, timeformat: Int) {
        tasks.append(task(name: name, dur: dur, timeformat: timeformat))
    }
    
    func editTask(index: Int, name: String, dur: Int, timeformat: Int) {
        tasks[index] = task(name: name, dur: dur, timeformat: timeformat)
    }
    
   
}
