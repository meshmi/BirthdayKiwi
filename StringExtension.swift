//
//  StringExtension.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 25/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

extension String {
    
    // MARK: - Custom Methods
    
    func removeLeadingAndTrailingWhitespaces() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}
