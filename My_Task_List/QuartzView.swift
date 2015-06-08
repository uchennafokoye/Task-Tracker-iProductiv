//
//  QuartzView.swift
//  My_Task_List
//
//  Created by Student on 6/7/15.
//  Copyright (c) 2015 Uchenna Okoye IOS Design. All rights reserved.
//

import UIKit

var inspirationalQuotes = [String]()

var randomGenerator : UInt32?
class QuartzView: UIView {
    
    

  
    override func drawRect(rect: CGRect) {
        
        
        inspirationalQuotes.append("You can make it. Just work hard")
        inspirationalQuotes.append("Never give up")
        inspirationalQuotes.append("Believe in yourself")
        inspirationalQuotes.append("Never give up")
        inspirationalQuotes.append("Fall six times. Get back up the seventh")
        
        var randomNo = randomGenerator!
        
        var text = inspirationalQuotes[0]
        switch randomNo {
        case 0:
            text = inspirationalQuotes[0]
            break
        case 1:
            text = inspirationalQuotes[1]
            break
        case 2:
            text = inspirationalQuotes[2]
            break
        case 4:
            text = inspirationalQuotes[3]
            break
        case 5:
            text = inspirationalQuotes[4]
            break
        default:
            break
            
            
            
        }


        // Drawing code
        
        if mysettings.inspirationSegment == 0 {
            drawCircle(50, y: 50)
            drawSquare(50, y: 100)
        } else if mysettings.inspirationSegment == 1 {
                        
            drawText(text, x: 50, y: 50)
            
        } else {
            drawCircle(50, y: 50)
            drawText(text, x: 50, y: 100)
            
        }
        
        
    }
    
    
    func drawCircle(x: Int, y: Int) {
    
    let context = UIGraphicsGetCurrentContext()
    
        
        // Drawing ovals and circles
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextSetFillColorWithColor(context, UIColor.redColor().CGColor)
        CGContextSetLineDash(context, 0, nil, 0)
    
        let rect = CGRect(x: x, y: y, width: 50, height: 50)
        CGContextStrokeEllipseInRect(context, rect)


    }
    
    func drawSquare(x: Int, y: Int) {
        
        // Drawing lines
        let context = UIGraphicsGetCurrentContext()
        // Drawing rectangles and squares
        CGContextSetStrokeColorWithColor(context, UIColor.greenColor().CGColor)
        CGContextSetFillColorWithColor(context, UIColor.yellowColor().CGColor)
        CGContextSetLineWidth(context, 2)
        
        let rect = CGRect(x: x, y: y, width: 80, height: 60)
        CGContextStrokeRect(context, rect)
        
        CGContextSetLineWidth(context, 4)
    }
    
    
    func drawText(text: String, x: Int, y: Int) {
        
        
        // Drawing text
        let text: NSString =  text
        
        
        var textAttr = [
            NSForegroundColorAttributeName : UIColor.magentaColor(),
            NSFontAttributeName : UIFont(name: "Papyrus", size: 15)!
        ]
        text.drawAtPoint(CGPoint(x: x, y: y), withAttributes: textAttr)
        
    }
}
