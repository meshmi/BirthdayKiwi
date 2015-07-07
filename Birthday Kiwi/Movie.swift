//
//  Movie.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 06/07/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

struct Movie {
    
    // MARK: - Properties
    
    var title: String?
    var id: Int?
    var releaseDate: String?
    
    // MARK: - Initializers
    
    init(dictionary: [String : AnyObject]) {
        title = dictionary[Client.TheMovieDBAPI_JSONResponseKeys.ORIGINAL_TITLE] as? String
        id = dictionary[Client.TheMovieDBAPI_JSONResponseKeys.ID] as? Int
        releaseDate = dictionary[Client.TheMovieDBAPI_JSONResponseKeys.RELEASE_DATE] as? String
    }
    
    // MARK: - Custom Methods
    
    // Convert given dictionary to array of Movie objects
    static func moviesFromResults(results: [[String : AnyObject]]) -> [Movie] {
        var movies = [Movie]()
        for result in results {
            movies.append(Movie(dictionary: result))
        }
        return movies
    }
}
