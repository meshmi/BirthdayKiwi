//
//  TableViewController.swift
//  Birthday Kiwi
//
//  Created by Dr. Paul R. Zahrl on 20/05/15.
//  Copyright (c) 2015 Dr. Paul R. Zahrl. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties
    
    let sharedContext = CoreDataStackManager.sharedInstance().managedObjectContext

    lazy var fetchedResultsController: NSFetchedResultsController = {
        let entityName = NSStringFromClass(Person.classForCoder())
        let fetchRequest = NSFetchRequest(entityName: entityName)
        
        let daySort = NSSortDescriptor(key: Client.Model_Attributes.BDAY_DAY, ascending: true)
        let monthSort = NSSortDescriptor(key: Client.Model_Attributes.BDAY_MONTH, ascending: true)
        
        fetchRequest.sortDescriptors = [monthSort, daySort]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext!, sectionNameKeyPath: Client.Model_Attributes.BDAY_MONTH, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    var selectedPerson: Person? // Used to keep track of selected person in didSelectRowAtIndexPath for prepareForSegue
    
    // MARK: - Actions
    
    @IBAction func add(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier(Client.Segue_Identifiers.NAME_VC, sender: self)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        var fetchingError: NSError?
        if self.fetchedResultsController.performFetch(&fetchingError) {
            println("Initial fetch successful")
        } else {
            println("Initial fetch failed")
        }
        
        self.fetchedResultsController.delegate = self
        
        // Add sample to database
        // Person(name: "Emma", bday_day: 01, bday_month: 04, bday_year: 1994, context: self.sharedContext!)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    // MARK: - UIViewController Methods 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Client.Segue_Identifiers.DETAIL_VC {
            if let selectedPerson = selectedPerson {
                (segue.destinationViewController as! DetailViewController).name = selectedPerson.name
                (segue.destinationViewController as! DetailViewController).birthday = Int(selectedPerson.bday_day)
                (segue.destinationViewController as! DetailViewController).birthmonth = Int(selectedPerson.bday_month)
                (segue.destinationViewController as! DetailViewController).birthyear = Int(selectedPerson.bday_year)
            }
        }
        
        if segue.identifier == Client.Segue_Identifiers.NAME_VC {
            // Hide navigation bar
            self.navigationController?.navigationBarHidden = true
            
            // Delete text in text field
            (segue.destinationViewController as! NameViewController).nameTextField?.text = ""
        }
    }

    // MARK: - NSFetchedResultsController Delegate Methods
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if type == NSFetchedResultsChangeType.Delete {
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        if type == NSFetchedResultsChangeType.Insert {
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        if type == NSFetchedResultsChangeType.Update {
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        if type == NSFetchedResultsChangeType.Delete {
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        }
        if type == NSFetchedResultsChangeType.Insert {
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        }
        if type == NSFetchedResultsChangeType.Update {
            tableView.reloadSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    // MARK: - UITableViewDataSource Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return self.fetchedResultsController.sections!.count
        //return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        let sectionInfo = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Client.TableView_Constants.CELL_IDENTIFIER, forIndexPath: indexPath) as! CustomTableViewCell

        let person = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Person
        
        cell.nameLabel.text = person.name
        cell.birthdateLabel.text = "\(DateAndTime.nameForMonth(Int(person.bday_month)).uppercaseString) \(person.bday_day), \(person.bday_year)"
        
        var birthdayComponents = NSDateComponents()
        birthdayComponents.day = Int(person.bday_day)
        birthdayComponents.month = Int(person.bday_month)
        birthdayComponents.year = Int(person.bday_year)
        
        let birthday = NSCalendar.currentCalendar().dateFromComponents(birthdayComponents)
        
        if let birthday = birthday {
            cell.ageLabel.text = "\(DateAndTime.calculateRemainingDaysUntilBirthday(birthday))"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sectionInfo = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        var monthInt = sectionInfo.name!.toInt()
        return viewForHeaderWithText(DateAndTime.nameForMonth(monthInt!).uppercaseString)
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let managedObject = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
            self.sharedContext?.deleteObject(managedObject)
            self.sharedContext?.save(nil)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let person = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Person
        
        self.selectedPerson = person
        
        self.performSegueWithIdentifier(Client.Segue_Identifiers.DETAIL_VC, sender: self)
    }
    
    // MARK: - Custom Methods
    
    func labelWithText(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        label.sizeToFit()
        return label
    }
    
    func viewForHeaderWithText(text: String) -> UIView {
        let label = labelWithText(text)
        
        label.frame.origin.x += 20
        label.frame.origin.y = 5
        
        let frame = CGRect(x: 0.0, y: 0.0, width: label.frame.size.width+20.0, height: label.frame.size.height)
        
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.darkGrayColor()
        view.addSubview(label)
        
        return view
    }
}
