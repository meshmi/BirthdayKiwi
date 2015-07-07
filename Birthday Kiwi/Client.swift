//
//  Client.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 20/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class Client: NSObject {
    
    // MARK: - Shared Instance
    
    class func sharedInstance() -> Client {
        struct Singleton {
            static var sharedInstance = Client()
        }
        
        return Singleton.sharedInstance
    }
    
    // MARK: - Properties
    
    var requestToken: String? = nil
    var sessionID: String? = nil
    var userID: Int? = nil

    let urlSession = NSURLSession.sharedSession()
    
    // MARK: - Custom Methods
    
    // Handles GET task for specified method on NSURLSession singleton; returns task
    func taskForGETMethod(method: String, arguments: [String: AnyObject]?, completionHandler: (result: AnyObject!, error: NSError?) -> Void) -> NSURLSessionDataTask {
        // Set the arguments
        var mutableArguments: [String: AnyObject] = arguments!
        mutableArguments[Client.TheMovieDBAPI_ParameterKeys.API_KEY] = Client.TheMovieDBAPI_Constants.API_KEY
        
        // Build URL, configure request
        let urlString = Client.TheMovieDBAPI_Constants.SECURE_BASE_URL + method + Client.escapeArguments(mutableArguments)
        var request = NSMutableURLRequest(URL: NSURL(string: urlString)!)
        request.HTTPMethod = "GET"
        
        // Make the request
        let task = urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                Client.parseJSONWithCompletionHandler(data, completionHandler: completionHandler)
            }
        })
        
        // Start the request
        task.resume()
        
        return task
        
    }
    
    // MARK: - Helper Methods
    
    // Parse JSON and return in completion handler
    class func parseJSONWithCompletionHandler(data: NSData, completionHandler: (result: AnyObject!, error: NSError?) -> Void) {
        var parsingError: NSError? = nil
        let parsedResult: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
        if let error = parsingError {
            completionHandler(result: nil, error: error)
        } else {
            completionHandler(result: parsedResult, error: nil)
        }
    }
    
    // Escape arguments for URL conformity, i. e. encode characters with percent and replace spaces with +
    class func escapeArguments(arguments: [String: AnyObject]?) -> String! {
        if arguments == nil {
            return ""
        }
        var urlArguments = [String]()
        for (key, value) in arguments! {
            // Make sure it is a string value
            let stringValue = "\(value)"
            // Escape string value
            let escapedString = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            // Replace spaces with +
            let replacedString = escapedString.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            urlArguments += [key + "=" + "\(replacedString)"]
        }
        return (urlArguments.isEmpty ? "" : "?") + join("&", urlArguments)
    }
}
