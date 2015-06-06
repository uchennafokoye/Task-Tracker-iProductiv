//
//  CheckboxDelegate.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/5/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import Foundation

protocol CheckboxDelegate {
    
    func didSelectCheckbox(state: Bool, identifier: Int, title: String)
    
}
