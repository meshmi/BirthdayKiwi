//
//  TwoDigitFieldView.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 25/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class DayMonthDigitFieldView: UIView {
    
    // MARK: - Structs
    
    struct Constants {
        static let DIGIT_HPADDING: CGFloat = 5.0
        static let DIGIT_VPADDING: CGFloat = 40.0
        static let DIGIT_COUNT = 2
        
        static let DIGIT_FONT = "DINCondensed-Bold"
        static let DIGIT_FONT_SIZE = 100.0
    }
    
    // MARK: - Properties
    
    var fieldWidth: CGFloat?
    var fieldHeight: CGFloat?

    var firstDigitLabel: UILabel?
    var secondDigitLabel: UILabel?
    
    var firstDigit: Int? {
        // Assign digit to label as soon as it is changed
        willSet(newValue) {
            if newValue != nil {
                firstDigitLabel?.text = "\(newValue!)"
            } else {
                firstDigitLabel?.text = ""
            }
        }
    }
    
    var secondDigit: Int? {
        willSet(newValue) {
            if newValue != nil {
                secondDigitLabel?.text = "\(newValue!)"
            } else {
                secondDigitLabel?.text = ""
            }
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.fieldWidth = frame.width
        self.fieldHeight = frame.height
        
        let digitY = Constants.DIGIT_VPADDING
        let digitWidth = frame.size.width/CGFloat(Constants.DIGIT_COUNT)-Constants.DIGIT_HPADDING*2
        let digitHeight = frame.size.height-Constants.DIGIT_VPADDING*2
        
        firstDigitLabel = UILabel(frame: CGRect(x: Constants.DIGIT_HPADDING, y: digitY, width: digitWidth, height: digitHeight))
        secondDigitLabel = UILabel(frame: CGRect(x: frame.size.width/CGFloat(Constants.DIGIT_COUNT)+Constants.DIGIT_HPADDING, y: digitY, width: digitWidth, height: digitHeight))
        
        let labels = [firstDigitLabel, secondDigitLabel]
        
        for label in labels {
            label?.font = UIFont(name: Constants.DIGIT_FONT, size: CGFloat(Constants.DIGIT_FONT_SIZE))
            label?.textAlignment = NSTextAlignment.Center
            label?.text = ""
            self.addSubview(label!)
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - UIView Methods
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        if let fieldWidth = self.fieldWidth, fieldHeight = self.fieldHeight {
            // Drawing code
            
            // Color to use when drawing the lines
            //UIColor.blueColor().set()
            
            // Get current graphics context
            let context = UIGraphicsGetCurrentContext()
            
            // Set line width
            CGContextSetLineWidth(context, 2.0)
            
            // Draw rectangle
            let path = CGPathCreateMutable()
            
            // Rectangle boundaries
            let rectangle = CGRect(x: 0.0, y: 0.0, width: fieldWidth, height: fieldHeight)
            
            // Add rectangle to path
            CGPathAddRect(path, nil, rectangle)
            
            // Add path to context
            CGContextAddPath(context, path)
            
            // Set fill color
            //UIColor.clearColor().setFill()
            
            // Set stroke color
            UIColor.blackColor().setStroke()
            
            // Draw
            CGContextDrawPath(context, kCGPathStroke)
            
            // Set line width
            CGContextSetLineWidth(context, 1.0)
            
            // Start line at point
            CGContextMoveToPoint(context, fieldWidth/2, 0.0)
            
            // End at point
            CGContextAddLineToPoint(context, fieldWidth/2, fieldHeight)
            
            // Draw line
            CGContextStrokePath(context)
        }
    }
    
    // MARK: - Custom Methods
    
    // For day digit field view only: Returns number of filled digits
    func addDayDigit(digit: Int) -> Int {
        if self.firstDigit == nil {
            self.firstDigit = digit
            return 1
        } else {
            self.secondDigit = digit
            if self.validateDayDigits() == true {
                return 2
            } else {
                return 0
            }
        }
    }
    
    // Add leading zero in case of tapping OK (i. e. only one digit has been entered)
    func addLeadingZero() -> Bool {
        self.secondDigit = self.firstDigit
        self.firstDigit = 0
        return true
    }
    
    // Reset digits to nil
    func invalidateDigits() {
        self.firstDigit = nil
        self.secondDigit = nil
    }
    
    // For day digit field view only: Validation of digits
    func validateDayDigits() -> Bool {
        if self.secondDigit != nil {
            if self.firstDigit > 3 {
                self.invalidateDigits()
                return false
            }
        }
        
        return true
        
        // Date validation?
    }
    
    // For month digit field view only: Set month digits
    func setMonthDigits(month: Int) -> Bool {
        if month < 10 {
            self.firstDigit = 0
            self.secondDigit = month
            return true
        } else {
            self.firstDigit = 1
            self.secondDigit = month % 10
            return true
        }
    }
    
    // Get digits
    func dayAsInt() -> Int? {
        if firstDigit != nil {
            if secondDigit != nil {
                return "\(firstDigit!)\(secondDigit!)".toInt()
            } else {
                return "\(firstDigit!)".toInt()
            }
        } else {
            return nil
        }
    }
}
