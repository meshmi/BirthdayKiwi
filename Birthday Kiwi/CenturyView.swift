//
//  CenturyView.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 30/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class CenturyView: UIView {
    
    // MARK: - Structs
    
    struct Constants {
        static let BUTTONS_PER_ROW = 2
        static let BUTTONS_PER_COLUMN = 1
        static let BUTTON_FONT_NAME = "DINCondensed-Bold"
        static let BUTTON_FONT_SIZE: CGFloat = 70.0
    }
    
    // MARK: - Properties
    
    var delegate: CenturyViewDelegate?
    
    var twentiethCenturyButton: UIButton?
    var twentyFirstCenturyButton: UIButton?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let buttonWidth = frame.size.width/CGFloat(Constants.BUTTONS_PER_ROW)
        let buttonHeight = frame.size.height/CGFloat(Constants.BUTTONS_PER_COLUMN)
        
        twentiethCenturyButton = UIButton(frame: CGRectMake(0.0, 0.0, buttonWidth, buttonHeight))
        twentyFirstCenturyButton = UIButton(frame: CGRectMake(buttonWidth, 0.0, buttonWidth, buttonHeight))
        
        var buttons = [twentiethCenturyButton, twentyFirstCenturyButton]
        var buttonTitles = [Client.CenturyView_ButtonTitles.TWENTIETH_CENTURY_BUTTON, Client.CenturyView_ButtonTitles.TWENTYFIRST_CENTURY_BUTTON]
        var buttonActions = [Selector("twentiethCentury:"), Selector("twentyFirstCentury:")]
        
        var buttonIndex = 0
        
        for button in buttons {
            button!.setTitle(buttonTitles[buttonIndex], forState: UIControlState.Normal)
            button!.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button!.titleLabel?.font = UIFont(name: Constants.BUTTON_FONT_NAME, size: Constants.BUTTON_FONT_SIZE)
            button!.tintColor = UIColor.blackColor()
            button!.backgroundColor  = UIColor.clearColor()
            button!.addTarget(self, action: buttonActions[buttonIndex], forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button!)
            buttonIndex++
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Custom Methods
    
    func twentiethCentury(sender: UIButton) {
        self.delegate?.twentiethCenturyTapped()
    }
    
    func twentyFirstCentury(sender: UIButton) {
        self.delegate?.twentyFirstCenturyTapped()
    }
    

}
