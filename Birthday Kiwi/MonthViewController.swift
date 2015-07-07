//
//  MonthViewController.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 24/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class MonthViewController: UIViewController, MonthViewDelegate {
    
    // MARK: - Properties
    
    var monthDigitFieldView: DayMonthDigitFieldView?
    
    var monthView: MonthView?
    
    // MARK: - Actions
    
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        if self.monthDigitFieldView == nil {
            self.monthDigitFieldView = DayMonthDigitFieldView(frame: CGRectMake(UIScreen.mainScreen().bounds.size.width/2-100.0, 181.0, 200.0, 200.0))
            self.monthDigitFieldView?.backgroundColor = UIColor.clearColor()
            self.view.addSubview(self.monthDigitFieldView!)
        }
        if monthView == nil {
            monthView = MonthView(frame: CGRectMake(0.0, UIScreen.mainScreen().bounds.size.height-250.0, UIScreen.mainScreen().bounds.size.width, 250.0))
            monthView?.delegate = self
            self.view.addSubview(monthView!)
        }
        // Make sure no digits are shown (especially after back button being pressed)
        self.monthDigitFieldView?.invalidateDigits()
    }
    
    // MARK: - UIViewController Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        YearViewController.month = self.monthDigitFieldView?.dayAsInt()
    }
    
    // MARK: - MonthViewDelegate Methods
    
    func januaryTapped() {
        self.setMonthDigits(1)
    }
    
    func februaryTapped() {
        self.setMonthDigits(2)
    }
    
    func marchTapped() {
        self.setMonthDigits(3)
    }
    
    func aprilTapped() {
        self.setMonthDigits(4)
    }
    
    func mayTapped() {
        self.setMonthDigits(5)
    }
    
    func juneTapped() {
        self.setMonthDigits(6)
    }
    
    func julyTapped() {
        self.setMonthDigits(7)
    }
    
    func augustTapped() {
        self.setMonthDigits(8)
    }
    
    func septemberTapped() {
        self.setMonthDigits(9)
    }
    
    func octoberTapped() {
        self.setMonthDigits(10)
    }
    
    func novemberTapped() {
        self.setMonthDigits(11)
    }
    
    func decemberTapped() {
        self.setMonthDigits(12)
    }

    // MARK: - Custom Methods
    
    private func next() {
        // No invalid entry possible, therefore perform segue only
        self.performSegueWithIdentifier(Client.Segue_Identifiers.YEAR_VC, sender: self)
    }
    
    private func setMonthDigits(month: Int) {
        if self.monthDigitFieldView?.setMonthDigits(month) == true {
            self.next()
        }
    }
}
