//
//  DateAndTime.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 24/06/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class DateAndTime {
    
    // MARK: - Custom Methods
    
    class func birthdateWithCurrentOrNextYear(birthdate: NSDate) -> NSDate {
        let cal = NSCalendar.currentCalendar()
        
        var componentsOfGivenDate = cal.components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear, fromDate: birthdate)
        
        var componentsOfCurrentDate = cal.components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear, fromDate: NSDate())
        
        // set apr 7 1983 to apr 7 2015
        
        componentsOfGivenDate.year = componentsOfCurrentDate.year
        
        let givenDate = cal.dateFromComponents(componentsOfGivenDate)
        
        // if apr 7 2015 > nsdate(): year+1
        // if nsdate() > apr 7 2015: apr 7 2016
        
        if givenDate?.timeIntervalSinceNow > 0 {
            componentsOfGivenDate.year = componentsOfCurrentDate.year
        } else {
            componentsOfGivenDate.year = componentsOfCurrentDate.year+1
        }
        
        return cal.dateFromComponents(componentsOfGivenDate)!
    }
    
    class func calculateRemainingDaysUntilBirthday(birthdate: NSDate) -> Int {
        var fromDate: NSDate?
        var toDate: NSDate?
        
        let cal = NSCalendar.currentCalendar()
        
        // Use this to make sure difference counts full days
        cal.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, startDate: &fromDate, interval: nil, forDate: NSDate())
        cal.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, startDate: &toDate, interval: nil, forDate: birthdateWithCurrentOrNextYear(birthdate))
        
        let days: NSDateComponents = cal.components(NSCalendarUnit.CalendarUnitDay, fromDate: fromDate!, toDate: toDate!, options: nil)
        
        return days.day
    }
    
    class func nameForMonth(month: Int) -> String {
        let months = [Client.MonthNames.JANUARY, Client.MonthNames.FEBRUARY, Client.MonthNames.MARCH, Client.MonthNames.APRIL, Client.MonthNames.MAY, Client.MonthNames.JUNE, Client.MonthNames.JULY, Client.MonthNames.AUGUST, Client.MonthNames.SEPTEMBER, Client.MonthNames.OCTOBER, Client.MonthNames.NOVEMBER, Client.MonthNames.DECEMBER]
        return months[month-1]
    }
    
    class func calculateAge(birthday: Int, birthmonth: Int, birthyear: Int) -> Int {
        let cal = NSCalendar.currentCalendar()
        let birthDate = cal.dateWithEra(1, year: birthyear, month: birthmonth, day: birthday, hour: 0, minute: 0, second: 0, nanosecond: 0)
        var componentsOfAge = cal.components(NSCalendarUnit.CalendarUnitYear, fromDate: birthDate!, toDate: NSDate(), options: nil)
        return componentsOfAge.year
    }
}
