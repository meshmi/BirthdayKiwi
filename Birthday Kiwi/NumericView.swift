//
//  NumericView.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 24/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class NumericView: UIView {
    
    // MARK: - Structs
    
    struct Constants {
        static let BUTTONS_PER_ROW = 3.0
        static let BUTTONS_PER_COLUMN = 4.0
        static let BUTTON_FONT_NAME = "DinAlternate-Bold"
        static let BUTTON_FONT_SIZE: CGFloat = 20.0
    }
    
    // MARK: - Properties
    
    var delegate: NumericViewDelegate?
    
    var oneButton: UIButton?
    var twoButton: UIButton?
    var threeButton: UIButton?
    var fourButton: UIButton?
    var fiveButton: UIButton?
    var sixButton: UIButton?
    var sevenButton: UIButton?
    var eightButton: UIButton?
    var nineButton: UIButton?
    
    var zeroButton: UIButton?
    
    var nextButton: UIButton?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let buttonWidth = frame.size.width/CGFloat(Constants.BUTTONS_PER_ROW)
        let buttonHeight = frame.size.height/CGFloat(Constants.BUTTONS_PER_COLUMN)
        
        oneButton = UIButton(frame: CGRectMake(0.0, 0.0, buttonWidth, buttonHeight))
        twoButton = UIButton(frame: CGRectMake(buttonWidth, 0.0, buttonWidth, buttonHeight))
        threeButton = UIButton(frame: CGRectMake(buttonWidth*2, 0.0, buttonWidth, buttonHeight))
        fourButton = UIButton(frame: CGRectMake(0.0, buttonHeight, buttonWidth, buttonHeight))
        fiveButton = UIButton(frame: CGRectMake(buttonWidth, buttonHeight, buttonWidth, buttonHeight))
        sixButton = UIButton(frame: CGRectMake(buttonWidth*2, buttonHeight, buttonWidth, buttonHeight))
        sevenButton = UIButton(frame: CGRectMake(0.0, buttonHeight*2, buttonWidth, buttonHeight))
        eightButton = UIButton(frame: CGRectMake(buttonWidth, buttonHeight*2, buttonWidth, buttonHeight))
        nineButton = UIButton(frame: CGRectMake(buttonWidth*2, buttonHeight*2, buttonWidth, buttonHeight))
        
        zeroButton = UIButton(frame: CGRectMake(buttonWidth, buttonHeight*3, buttonWidth, buttonHeight))
 
        nextButton = UIButton(frame: CGRectMake(buttonWidth*2, buttonHeight*3, buttonWidth, buttonHeight))
        
        var buttons = [oneButton, twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton, zeroButton, nextButton]
        var buttonTitles = [Client.NumericView_ButtonTitles.ONE_BUTTON, Client.NumericView_ButtonTitles.TWO_BUTTON, Client.NumericView_ButtonTitles.THREE_BUTTON, Client.NumericView_ButtonTitles.FOUR_BUTTON, Client.NumericView_ButtonTitles.FIVE_BUTTON, Client.NumericView_ButtonTitles.SIX_BUTTON, Client.NumericView_ButtonTitles.SEVEN_BUTTON, Client.NumericView_ButtonTitles.EIGHT_BUTTON, Client.NumericView_ButtonTitles.NINE_BUTTON, Client.NumericView_ButtonTitles.ZERO_BUTTON, Client.NumericView_ButtonTitles.NEXT_BUTTON]
        var buttonActions = [Selector("one:"), Selector("two:"), Selector("three:"), Selector("four:"), Selector("five:"), Selector("six:"), Selector("seven:"), Selector("eight:"), Selector("nine:"), Selector("zero:"), Selector("next:")]
        
        // Set buttonIndex to 0 which keeps track of current button in loop
        var buttonIndex = 0
        
        // Loop through buttons to set common properties
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
        
        nextButton!.enabled = false
        nextButton!.hidden = false
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Custom Methods
    
    func enableNextButton(enable: Bool) {
        nextButton!.enabled = enable
    }
    
    // Hide next button for use in YearViewController
    func hideNextButton() {
        nextButton!.hidden = true
    }
    
    func one(sender: UIButton) {
        self.delegate?.oneTapped()
    }
    
    func two(sender: UIButton) {
        self.delegate?.twoTapped()
    }
    
    func three(sender: UIButton) {
        self.delegate?.threeTapped()
    }
    
    func four(sender: UIButton) {
        self.delegate?.fourTapped()
    }
    
    func five(sender: UIButton) {
        self.delegate?.fiveTapped()
    }
    
    func six(sender: UIButton) {
        self.delegate?.sixTapped()
    }
    
    func seven(sender: UIButton) {
        self.delegate?.sevenTapped()
    }
    
    func eight(sender: UIButton) {
        self.delegate?.eightTapped()
    }
    
    func nine(sender: UIButton) {
        self.delegate?.nineTapped()
    }
    
    func zero(sender: UIButton) {
        self.delegate?.zeroTapped()
    }
    
    func next(sender: UIButton) {
        self.delegate?.nextTapped()
    }
}
