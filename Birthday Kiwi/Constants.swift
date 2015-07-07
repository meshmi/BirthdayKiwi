//
//  Constants.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 20/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

extension Client {
    
    // MARK: - Numeric View Button Titles
    
    struct NumericView_ButtonTitles {
        static let ZERO_BUTTON = "0"
        static let ONE_BUTTON = "1"
        static let TWO_BUTTON = "2"
        static let THREE_BUTTON = "3"
        static let FOUR_BUTTON = "4"
        static let FIVE_BUTTON = "5"
        static let SIX_BUTTON = "6"
        static let SEVEN_BUTTON = "7"
        static let EIGHT_BUTTON = "8"
        static let NINE_BUTTON = "9"
        static let NEXT_BUTTON = "OK"
    }
    
    // MARK: - Month View Button Titles
    
    struct MonthView_ButtonTitles {
        static let JANUARY_BUTTON = "JAN"
        static let FEBRUARY_BUTTON = "FEB"
        static let MARCH_BUTTON = "MAR"
        static let APRIL_BUTTON = "APR"
        static let MAY_BUTTON = "MAY"
        static let JUNE_BUTTON = "JUN"
        static let JULY_BUTTON = "JUL"
        static let AUGUST_BUTTON = "AUG"
        static let SEPTEMBER_BUTTON = "SEP"
        static let OCTOBER_BUTTON = "OCT"
        static let NOVEMBER_BUTTON = "NOV"
        static let DECEMBER_BUTTON = "DEC"
    }
    
    // MARK: - Month Names
    
    struct MonthNames {
        static let JANUARY = "January"
        static let FEBRUARY = "February"
        static let MARCH = "March"
        static let APRIL = "April"
        static let MAY = "May"
        static let JUNE = "June"
        static let JULY = "July"
        static let AUGUST = "August"
        static let SEPTEMBER = "September"
        static let OCTOBER = "October"
        static let NOVEMBER = "November"
        static let DECEMBER = "December"
    }
    
    // MARK: - Century View Button Titles
    
    struct CenturyView_ButtonTitles {
        static let TWENTIETH_CENTURY_BUTTON = "19.."
        static let TWENTYFIRST_CENTURY_BUTTON = "20.."
    }
    
    // MARK: - Segue Identifiers
    
    struct Segue_Identifiers {
        static let NAME_VC = "showNameVC"
        static let DAY_VC = "showDayVC"
        static let MONTH_VC = "showMonthVC"
        static let YEAR_VC = "showYearVC"
        static let DETAIL_VC = "showDetailVC"
    }
    
    // MARK: - Table View Identifiers
    
    struct TableView_Constants {
        static let CELL_IDENTIFIER = "Cell"
    }
   
    // MARK: - Core Data Entities
    
    struct Model_Entities {
        static let PERSON = "Person"
    }
    
    // MARK: - Core Data Attributes
    
    struct Model_Attributes {
        static let BDAY_DAY = "bday_day"
        static let BDAY_MONTH = "bday_month"
        static let BDAY_YEAR = "bday_year"
        static let NAME = "name"
    }
    
    // MARK: - Error Messages
    
    struct Errors {
        static let NAME_EXISTS_ALREADY = "This name exists already. Please enter another one."
    }
    
    // MARK: - TheMovieDB Structs
    
    struct TheMovieDBAPI_Constants {
        
        // API Key
        // static properties in classes have global storage and are lazily initialized on first access (like global variables)
        static let API_KEY = "0070ad1ed541859b5c40d8646e2f27c3"
        
        // Base URL
        static let SECURE_BASE_URL = "https://api.themoviedb.org/3/"
        
    }
    
    struct TheMovieDBAPI_Methods {
        /* 
        Name:
            /authentication/token/new
        Required Arguments:
            api_key
        API Documentation:
            This method is used to generate a valid request token for user based authentication. A request token is required in order to request a session id.
            You can generate any number of request tokens but they will expire after 60 minutes. As soon as a valid session id has been created the token will be destroyed. */
        
        static let authenticationTokenNew = "authentication/token/new"
        
        /*
        Name: 
            /authentication/session/new
        Required Arguments:
            api_key
            request_token
        API Documentation:
            This method is used to generate a session id for user based authentication. A sessioon id is required in order to use any of the write methods. */
        
        static let authenticationSessionNew = "authentication/session/new"
        
        /* 
        Name:
            /discover/movie
        Required Arguments: 
            api_key
        Optional: 
            primary_release_year
            sort_by: release_date.asc
        */
        
        static let discoverMovie = "discover/movie"
    }
    
    struct TheMovieDBAPI_Arguments {
        static let API_KEY = "api_key"
        static let REQUEST_TOKEN = "request_token"
    }
    
    struct TheMovieDBAPI_JSONResponseKeys {
        static let ORIGINAL_TITLE = "original_title"
        static let ID = "id"
        static let RELEASE_DATE = "release_date"
        static let RESULTS = "results"
    }
    
    struct TheMovieDBAPI_ParameterKeys {
        static let PRIMARY_RELEASE_YEAR = "primary_release_year"
        static let SORT_BY = "sort_by"
        static let API_KEY = "api_key"
    }
    
    struct TheMovieDBAPI_Parameters {
        static let RELEASE_DATE_ASC = "release_date.asc"
    }
}
