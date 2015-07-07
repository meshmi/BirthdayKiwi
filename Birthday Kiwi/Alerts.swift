//
//  Alerts.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 25/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class Alerts: NSObject {
    
    // MARK: - Custom Methods
    
    // Display an error message to the user (using UIAlertController)
    class func displayError(errorString: String, hostViewController: UIViewController) -> Void {
        var alertController: UIAlertController = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
        var okAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in }
        alertController.addAction(okAction)
        hostViewController.presentViewController(alertController, animated: true, completion: nil)
    }
}
