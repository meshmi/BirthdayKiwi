//
//  MonthView.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 30/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class MonthView: UIView {
    
    // MARK: - Structs
    
    struct Constants {
        static let BUTTONS_PER_ROW = 3
        static let BUTTONS_PER_COLUMN = 4
        static let BUTTON_FONT_NAME = "DINAlternate-Bold"
        static let BUTTON_FONT_SIZE: CGFloat = 20.0
    }
    
    // MARK: - Properties
    
    var delegate: MonthViewDelegate?
    
    var januaryButton: UIButton?
    var februaryButton: UIButton?
    var marchButton: UIButton?
    var aprilButton: UIButton?
    var mayButton: UIButton?
    var juneButton: UIButton?
    var julyButton: UIButton?
    var augustButton: UIButton?
    var septemberButton: UIButton?
    var octoberButton: UIButton?
    var novemberButton: UIButton?
    var decemberButton: UIButton?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let buttonWidth = frame.size.width/CGFloat(Constants.BUTTONS_PER_ROW)
        let buttonHeight = frame.size.height/CGFloat(Constants.BUTTONS_PER_COLUMN)
        
        januaryButton = UIButton(frame: CGRectMake(0.0, 0.0, buttonWidth, buttonHeight))
        februaryButton = UIButton(frame: CGRectMake(buttonWidth, 0.0, buttonWidth, buttonHeight))
        marchButton = UIButton(frame: CGRectMake(buttonWidth*2, 0.0, buttonWidth, buttonHeight))
        aprilButton = UIButton(frame: CGRectMake(0.0, buttonHeight, buttonWidth, buttonHeight))
        mayButton = UIButton(frame: CGRectMake(buttonWidth, buttonHeight, buttonWidth, buttonHeight))
        juneButton = UIButton(frame: CGRectMake(buttonWidth*2, buttonHeight, buttonWidth, buttonHeight))
        julyButton = UIButton(frame: CGRectMake(0.0, buttonHeight*2, buttonWidth, buttonHeight))
        augustButton = UIButton(frame: CGRectMake(buttonWidth, buttonHeight*2, buttonWidth, buttonHeight))
        septemberButton = UIButton(frame: CGRectMake(buttonWidth*2, buttonHeight*2, buttonWidth, buttonHeight))
        octoberButton = UIButton(frame: CGRectMake(0.0, buttonHeight*3, buttonWidth, buttonHeight))
        novemberButton = UIButton(frame: CGRectMake(buttonWidth, buttonHeight*3, buttonWidth, buttonHeight))
        decemberButton = UIButton(frame: CGRectMake(buttonWidth*2, buttonHeight*3, buttonWidth, buttonHeight))
        
        var buttons = [januaryButton, februaryButton, marchButton, aprilButton, mayButton, juneButton, julyButton, augustButton, septemberButton, octoberButton, novemberButton, decemberButton]
        var buttonTitles = [Client.MonthView_ButtonTitles.JANUARY_BUTTON, Client.MonthView_ButtonTitles.FEBRUARY_BUTTON, Client.MonthView_ButtonTitles.MARCH_BUTTON, Client.MonthView_ButtonTitles.APRIL_BUTTON, Client.MonthView_ButtonTitles.MAY_BUTTON, Client.MonthView_ButtonTitles.JUNE_BUTTON, Client.MonthView_ButtonTitles.JULY_BUTTON, Client.MonthView_ButtonTitles.AUGUST_BUTTON, Client.MonthView_ButtonTitles.SEPTEMBER_BUTTON, Client.MonthView_ButtonTitles.OCTOBER_BUTTON, Client.MonthView_ButtonTitles.NOVEMBER_BUTTON, Client.MonthView_ButtonTitles.DECEMBER_BUTTON]
        var buttonActions = [Selector("january:"), Selector("february:"), Selector("march:"), Selector("april:"), Selector("may:"), Selector("june:"), Selector("july:"), Selector("august:"), Selector("september:"), Selector("october:"), Selector("november:"), Selector("december:")]
        
        var buttonIndex = 0
        
        for button in buttons {
            button!.setTitle(buttonTitles[buttonIndex], forState: UIControlState.Normal)
            button!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button!.titleLabel?.font = UIFont(name: Constants.BUTTON_FONT_NAME, size: Constants.BUTTON_FONT_SIZE)
            button!.tintColor = UIColor.blackColor()
            button!.backgroundColor = UIColor.clearColor()
            button!.addTarget(self, action: buttonActions[buttonIndex], forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button!)
            buttonIndex++
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Custom Methods
    
    func january(sender: UIButton) {
        self.delegate?.januaryTapped()
    }
    
    func february(sender: UIButton) {
        self.delegate?.februaryTapped()
    }
    
    func march(sender: UIButton) {
        self.delegate?.marchTapped()
    }
    
    func april(sender: UIButton) {
        self.delegate?.aprilTapped()
    }
    
    func may(sender: UIButton) {
        self.delegate?.mayTapped()
    }
    
    func june(sender: UIButton) {
        self.delegate?.juneTapped()
    }
    
    func july(sender: UIButton) {
        self.delegate?.julyTapped()
    }
    
    func august(sender: UIButton) {
        self.delegate?.augustTapped()
    }
    
    func september(sender: UIButton) {
        self.delegate?.septemberTapped()
    }
    
    func october(sender: UIButton) {
        self.delegate?.octoberTapped()
    }
    
    func november(sender: UIButton) {
        self.delegate?.novemberTapped()
    }
    
    func december(sender: UIButton) {
        self.delegate?.decemberTapped()
    }
}
