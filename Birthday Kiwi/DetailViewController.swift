//
//  DetailViewController.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 05/07/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    var name: String?
    var birthday: Int?
    var birthmonth: Int?
    var birthyear: Int?
    
    var retrievedMovies: [String]?
    
    let cellIdentifier = "Cell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var moviesFromYearLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
    }
    
    override func viewWillAppear(animated: Bool) {
        if let name = name {
            nameLabel.text = name
        }
        
        if let birthday = birthday, birthmonth = birthmonth, birthyear = birthyear {
            birthdateLabel.text = "\(birthmonth)/\(birthday)/\(birthyear)"
        }
        
        if let birthyear = birthyear {
            
            moviesFromYearLabel.text = "MOVIES RELEASED IN \(birthyear)"
            
            ageLabel.text = "\(DateAndTime.calculateAge(birthday!, birthmonth: birthmonth!, birthyear: birthyear)) YEARS OLD"
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            })
            Client.getMoviesForYear(birthyear, completionHandler: { (result, error) -> Void in
                if let error = error {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    })
                    
                    println("error while trying to retrieve movies")
                } else {
                    self.retrievedMovies = []
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    })
                    
                    if result!.isEmpty {
                        self.retrievedMovies?.append("< NO MOVIES AVAILABLE >")
                    } else {
                        for movie in result! {
                            self.retrievedMovies?.append(movie.title!)
                        }
                        
                        self.retrievedMovies = sorted(self.retrievedMovies!)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }
            })
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let retrievedMovies = self.retrievedMovies {
            return retrievedMovies.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as! UITableViewCell
        
        cell.textLabel?.font = UIFont(name: "Courier", size: 14.0)
        
        cell.textLabel?.text = self.retrievedMovies![indexPath.row]
        
        return cell
    }
    
}
