//
//  YearDigitFieldView.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 01/06/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class YearDigitFieldView: UIView {
    
    // MARK: - Structs
    
    struct Constants {
        static let DIGIT_HPADDING: CGFloat = 5.0
        static let DIGIT_VPADDING: CGFloat = 40.0
        static let DIGIT_COUNT = 4
        
        static let DIGIT_FONT = "DinCondensed-Bold"
        static let DIGIT_FONT_SIZE = 100.0
    }
    
    // MARK: - Properties

    var fieldWidth: CGFloat?
    var fieldHeight: CGFloat?
    
    var firstDigitLabel: UILabel?
    var secondDigitLabel: UILabel?
    var thirdDigitLabel: UILabel?
    var fourthDigitLabel: UILabel?
    
    var firstDigit: Int? {
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
    
    var thirdDigit: Int? {
        willSet(newValue) {
            if newValue != nil {
                thirdDigitLabel?.text = "\(newValue!)"
            } else {
                thirdDigitLabel?.text = ""
            }
        }
    }
    
    var fourthDigit: Int? {
        willSet(newValue) {
            if newValue != nil {
                fourthDigitLabel?.text = "\(newValue!)"
            } else {
                fourthDigitLabel?.text = ""
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
        thirdDigitLabel = UILabel(frame: CGRect(x: (frame.size.width/CGFloat(Constants.DIGIT_COUNT))*2+Constants.DIGIT_HPADDING, y: digitY, width: digitWidth, height: digitHeight))
        fourthDigitLabel = UILabel(frame: CGRect(x: (frame.size.width/CGFloat(Constants.DIGIT_COUNT))*3+Constants.DIGIT_HPADDING, y: digitY, width: digitWidth, height: digitHeight))
        
        let labels = [firstDigitLabel, secondDigitLabel, thirdDigitLabel, fourthDigitLabel]
        
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
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        if let fieldWidth = fieldWidth, fieldHeight = fieldHeight {
            let context = UIGraphicsGetCurrentContext()
            CGContextSetLineWidth(context, 2.0)
            let path = CGPathCreateMutable()
            let rectangle = CGRect(x: 0.0, y: 0.0, width: fieldWidth, height: fieldHeight)
            CGPathAddRect(path, nil, rectangle)
            CGContextAddPath(context, path)
            UIColor.blackColor().setStroke()
            CGContextDrawPath(context, kCGPathStroke)
            CGContextSetLineWidth(context, 1.0)
            CGContextMoveToPoint(context, fieldWidth/4, 0.0)
            CGContextAddLineToPoint(context, fieldWidth/4, fieldHeight)
            CGContextStrokePath(context)
            
            CGContextMoveToPoint(context, (fieldWidth/4)*2, 0.0)
            CGContextAddLineToPoint(context, (fieldWidth/4)*2, fieldHeight)
            CGContextStrokePath(context)
            
            CGContextMoveToPoint(context, (fieldWidth/4)*3, 0.0)
            CGContextAddLineToPoint(context, (fieldWidth/4)*3, fieldHeight)
            CGContextStrokePath(context)
        }
    }
    
    // MARK: - Custom Methods
    
    // returns number of filled digits
    func addDigit(digit: Int) -> Int {
        if self.thirdDigit == nil {
            self.thirdDigit = digit
            return 3
        } else {
            self.fourthDigit = digit
            if self.validateDigits() == true {
                return 4
            } else {
                return 0
            }
        }
    }
    
    // Get digits
    func getDigits() -> Int? {
        if let firstDigit = firstDigit, secondDigit = secondDigit, thirdDigit = thirdDigit, fourthDigit = fourthDigit {
            return "\(firstDigit)\(secondDigit)\(thirdDigit)\(fourthDigit)".toInt()
        } else {
            return nil
        }
    }
    
    // Make sure digits don't exceed current year
    func validateDigits() -> Bool {
        // Validate only if year is in 21st century
        if "\(self.firstDigit)\(self.secondDigit)".toInt() == 20 {
            var enteredYear = 0
            if self.fourthDigit != nil {
                enteredYear = "\(self.thirdDigit)\(self.fourthDigit)".toInt()!
            }
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate: NSDate())
            let currentYear = components.year
            
            if enteredYear <= currentYear {
                return true
            } else {
                return false
            }
        } else {
            // Always return true if year is in the 20th century
            return true
        }
    }
}
