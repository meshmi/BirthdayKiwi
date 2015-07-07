//
//  YearViewController.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 24/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class YearViewController: UIViewController, CenturyViewDelegate, NumericViewDelegate {
    
    // MARK: - Properties
    
    // Store values from previous view controllers
    static var name: String?
    static var day: Int?
    static var month: Int?
    
    var yearDigitFieldView: YearDigitFieldView?
    
    var centuryView: CenturyView?
    var numericView: NumericView?
    
    let sharedContext = CoreDataStackManager.sharedInstance().managedObjectContext

    // MARK: - Actions
    
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        if self.yearDigitFieldView == nil {
            let digitFieldWidth: CGFloat = 300.0
            self.yearDigitFieldView = YearDigitFieldView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2-digitFieldWidth/2, 181.0, digitFieldWidth, 200.0))
            self.yearDigitFieldView?.backgroundColor = UIColor.clearColor()
            self.view.addSubview(self.yearDigitFieldView!)
        }
        if centuryView == nil {
            centuryView = CenturyView(frame: CGRectMake(0.0, UIScreen.mainScreen().bounds.size.height-250.0, UIScreen.mainScreen().bounds.size.width, 250.0))
            centuryView?.delegate = self
            self.view.addSubview(centuryView!)
        }
        if numericView == nil {
            numericView = NumericView(frame: CGRectMake(0.0, UIScreen.mainScreen().bounds.size.height-250.0, UIScreen.mainScreen().bounds.size.width, 250.0))
            numericView?.delegate = self
            numericView?.hideNextButton()
            numericView?.hidden = true
            self.view.addSubview(numericView!)
        }
    }
    
    // MARK: - CenturyViewDelegate Methods

    private func switchToNumericView() {
        self.centuryView?.hidden = true
        self.yearDigitFieldView?.hidden = false
        self.numericView?.hidden = false
    }
    
    internal func twentiethCenturyTapped() {
        self.switchToNumericView()
        
        self.yearDigitFieldView?.firstDigit = 1
        self.yearDigitFieldView?.secondDigit = 9
    }
    
    internal func twentyFirstCenturyTapped() {
        self.switchToNumericView()
        
        self.yearDigitFieldView?.firstDigit = 2
        self.yearDigitFieldView?.secondDigit = 0
    }
    
    // MARK: - NumericViewDelegate Methods
    
    internal func oneTapped() {
        self.addDigit(1)
    }
    
    internal func twoTapped() {
        self.addDigit(2)
    }
    
    internal func threeTapped() {
        self.addDigit(3)
    }
    
    internal func fourTapped() {
        self.addDigit(4)
    }
    
    internal func fiveTapped() {
        self.addDigit(5)
    }
    
    internal func sixTapped() {
        self.addDigit(6)
    }
    
    internal func sevenTapped() {
        self.addDigit(7)
    }
    
    internal func eightTapped() {
        self.addDigit(8)
    }
    
    internal func nineTapped() {
        self.addDigit(9)
    }
    
    internal func zeroTapped() {
        self.addDigit(0)
    }
    
    internal func nextTapped() {
        // Not applicable because next button is hidden in YearViewController
    }
    
    // MARK: - Custom Methods
    
    private func addAndHide() {
        if let sharedContext = self.sharedContext, name = YearViewController.name, day = YearViewController.day, month = YearViewController.month, year = yearDigitFieldView?.getDigits() {
            Person(name: name, bday_day: day, bday_month: month, bday_year: year, context: sharedContext)
            
            var savingError: NSError?
            if sharedContext.save(&savingError) {
                println("MOC saved")
            } else {
                if let error = savingError {
                    println("Error saving MOC \(error.description)")
                }
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    private func addDigit(digit: Int) {
        var digits = yearDigitFieldView?.addDigit(digit)
        if digits == 4 {
            addAndHide()
        }
    }

}
