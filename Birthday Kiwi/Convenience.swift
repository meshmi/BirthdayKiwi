//
//  Convenience.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 21/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

extension Client {

    // MARK: - Custom Methods
    
    class func getMoviesForYear(year: Int, completionHandler: (result: [Movie]?, error: NSError?) -> Void) -> NSURLSessionTask? {
        let parameters = [Client.TheMovieDBAPI_ParameterKeys.PRIMARY_RELEASE_YEAR: year]
        let task = Client.sharedInstance().taskForGETMethod(Client.TheMovieDBAPI_Methods.discoverMovie, arguments: parameters) { (result, error) -> Void in
            if let error = error {
                completionHandler(result: nil, error: error)
            } else {
                if let results = result.valueForKey(Client.TheMovieDBAPI_JSONResponseKeys.RESULTS) as? [[String : AnyObject]] {
                    var movies = Movie.moviesFromResults(results)
                    completionHandler(result: movies, error: nil)
                } else {
                    completionHandler(result: nil, error: NSError(domain: "getMoviesForYear parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getMoviesForYear"]))
                }
            }
        }
        return task
    }
}
