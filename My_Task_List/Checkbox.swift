//
//  Checkbox.swift
//  My_Task_List
//
//  Created by Faithful Okoye on 6/5/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit

class Checkbox: UIButton {

   
    var mDelegate: CheckboxDelegate?
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, title: String, selected: Bool) {
        super.init(frame: frame)
        self.adjustEdgeInsets()
        self.applyStyle()
        self.setTitle(title, forState: UIControlState.Normal)
        
    }

   
    
    func adjustEdgeInsets() {
        let lLeftInset: CGFloat = 8.0;
        // #3
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        // #4
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0 as CGFloat, lLeftInset, 0.0 as CGFloat, 0.0 as CGFloat);
        // #5
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0 as CGFloat, (lLeftInset * 2), 0.0 as CGFloat, 0.0 as CGFloat);
    }
    
    
    // #6
    func applyStyle() {
        self.setImage(UIImage(named: "checked_checkbox"), forState: UIControlState.Selected);
        self.setImage(UIImage(named: "unchecked_checkbox"), forState: UIControlState.Normal);
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
    }
    
    func onTouchUpInside(sender: UIButton) {
        // #7
        self.selected = !self.selected;
        // #8
        mDelegate?.didSelectCheckbox(self.selected, identifier: self.tag, title: self.titleLabel!.text!);
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    

}
