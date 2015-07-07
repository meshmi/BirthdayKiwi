//
//  DayViewController.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 24/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class DayViewController: UIViewController, NumericViewDelegate {
    
    // MARK: - Properties
    
    var dayDigitFieldView: DayMonthDigitFieldView?
    
    var numericView: NumericView?
    
    // MARK: - Actions
    
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        // If DayMonthDigitFieldView doesn't exist in view yet add it
        if self.dayDigitFieldView == nil {
            self.dayDigitFieldView = DayMonthDigitFieldView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2-100.0, 181.0, 200.0, 200.0))
            self.dayDigitFieldView?.backgroundColor = UIColor.clearColor()
            self.view.addSubview(self.dayDigitFieldView!)
        }
        if numericView == nil {
            numericView = NumericView(frame: CGRectMake(0.0, UIScreen.mainScreen().bounds.size.height-250.0, UIScreen.mainScreen().bounds.size.width, 250.0))
            numericView?.delegate = self
            self.view.addSubview(numericView!)
        }
        // Always make sure that no digits are shown are shown when view is being presented (especially after back button being pressed)
        self.dayDigitFieldView?.invalidateDigits()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - UIViewController Methods

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        YearViewController.day = self.dayDigitFieldView?.dayAsInt()
    }
    
    // MARK: - NumericViewDelegate Methods
    
    func oneTapped() {
        self.addDigit(1)
    }
    
    func twoTapped() {
        self.addDigit(2)
    }
    
    func threeTapped() {
        self.addDigit(3)
    }

    func fourTapped() {
        self.addDigit(4)
    }
    
    func fiveTapped() {
        self.addDigit(5)
    }
    
    func sixTapped() {
        self.addDigit(6)
    }
    
    func sevenTapped() {
        self.addDigit(7)
    }
    
    func eightTapped() {
        self.addDigit(8)
    }
    
    func nineTapped() {
        self.addDigit(9)
    }
    
    func zeroTapped() {
        self.addDigit(0)
    }
    
    func nextTapped() {
        if self.dayDigitFieldView?.addLeadingZero() == true {
            next()
        }
    }
    
    // MARK: - Custom Methods
    
    private func next() {
        // Validation of entry is handled in NumericView, state of "next" button in this class, therefore here only segue has to be performed
        self.performSegueWithIdentifier(Client.Segue_Identifiers.MONTH_VC, sender: self)
    }
    
    private func addDigit(digit: Int) {
        var digits = self.dayDigitFieldView?.addDayDigit(digit)
        // Handle state of "next" button and continue if two valid digits have been entered
        if digits == 2 {
            self.numericView?.enableNextButton(true)
            next()
        } else if digits == 1 {
            self.numericView?.enableNextButton(true)
        } else if digits == 0 {
            self.numericView?.enableNextButton(false)
        }
    }
}
