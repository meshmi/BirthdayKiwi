//
//  NameViewController.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 24/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class NameViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    var nameTextField : UITextField?
    
    // MARK: - Actions
    
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        // Add UITextField programmatically, because autoshrink of text doesn't work with IB
        if nameTextField == nil {
            self.nameTextField = UITextField(frame: CGRectMake(16.0, 181.0, UIScreen.mainScreen().bounds.size.width-16.0*2, 113.0))
            self.nameTextField?.backgroundColor = UIColor.clearColor()
            self.nameTextField?.adjustsFontSizeToFitWidth = true
            self.nameTextField?.font = UIFont(name: "DINCondensed-Bold", size: 100.0)
            self.nameTextField?.minimumFontSize = 20.0
            self.nameTextField?.textAlignment = NSTextAlignment.Center
            self.nameTextField?.autocapitalizationType = UITextAutocapitalizationType.AllCharacters
            self.nameTextField?.delegate = self
            self.nameTextField?.text = ""
            self.view.addSubview(self.nameTextField!)
        }
    }

    override func viewDidAppear(animated: Bool) {
        // Make text field become the first responder
        self.nameTextField?.becomeFirstResponder()
    }
    
    // MARK: - UIViewController Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        YearViewController.name = nameTextField?.text
    }
    
    // MARK: - UITextFieldDelegate Methods
    
    // Continue as soon as user taps return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.next()
        return false
    }
    
    /* Setting a maximum length for a text field using textField(_:shouldChangeCharactersInRange:replacementString:) as there is no maxLength property or equivalent:
    
    NSRange describes a portion of a series consisting of location and length of the change in question. Therefore entering a returns (0,0), adding a (aa) returns (1,0), adding a (aaa) returns (2,0) and so on. Adding b at the beginning (baaa) returns (0,0) again.
    The ...,0 indicates that no character is being changed. If we change aaa to aca then we'll get (1,1).
    
    countElements(textfield.text) returns the length of the text before a change has taken place.
    
    The string argument returns the length of the new chars. Therefore 1 if only one char is added or replaced or 2 if two chars are pasted in, 0 if one char or more chars are being deleted etc.
    
    We have to calculate the text length before editing (textfield.text) + the number of new chars (string) - number of deleted chars (range.length).*/
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        // Make sure text is always uppercase
        var lowercaseRange = string.rangeOfCharacterFromSet(NSCharacterSet.lowercaseLetterCharacterSet(), options: nil, range: nil)
        
        if (range.length+range.location > count(textField.text)) {
            return false
        }
        
        if lowercaseRange != nil {
            if (count(textField.text)+count(string)-range.length) <= 25 {
                textField.text = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string.uppercaseString)
                return false
            }
        }
        
        // Limit text to 25 chars
        return (count(textField.text)+count(string)-range.length) <= 25
    }
    
    // MARK: - Custom Methods
    
    private func next() {
        // Proceed only if name has been entered
        if nameTextField!.text.removeLeadingAndTrailingWhitespaces() != "" {
            // Proceed only if name doesn't exist already
            if Database.checkDatabaseForName(nameTextField!.text) == false {
                self.performSegueWithIdentifier(Client.Segue_Identifiers.DAY_VC, sender: self)
            } else {
                Alerts.displayError(Client.Errors.NAME_EXISTS_ALREADY, hostViewController: self)
            }
        }
    }
}
