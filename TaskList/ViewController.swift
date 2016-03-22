//
//  ViewController.swift
//  TaskList
//
//  Created by Speros Misirlakis on 2/19/16.
//  Copyright © 2016 Speros Misirlakis. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GoBackProtocol {

    @IBOutlet weak var textFieldForNewTask: UITextField!
    @IBOutlet weak var tableViewObjectForTasks: UITableView!
    var tasks: [Task] = []

    
    // ========================= GoBackProtocol =========================
    func goBack(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    // ==================================================================
    

    
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    // ========================= UIViewController =========================
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        print(segue)
        //        print(segue.identifier)
        //        print("Sender:", sender) // what made it change views

        if segue.identifier == "goToTaskDetail" {
            print("here");
            // Craete an object of the Navigation Controller
            let navigationController = segue.destinationViewController as! UINavigationController
            // Create an object of the Nagivation Controller's top view controller (the new view: TaskDetailsController)
            let taskDetailsController = navigationController.topViewController as! TaskDetailsController
            
            // Add to this controller, the functionality of our current controller in the delegate.
            taskDetailsController.delegate = self

            // Retrieve the object at the index that it was clicked on
            let taskIndexPath = tableViewObjectForTasks.indexPathForCell(sender as! UITableViewCell)
            
            taskDetailsController.task = tasks[taskIndexPath!.row]
            

            print("taskDetailsController.task", taskDetailsController.task)
        }
        
    }
    
    // ========================= UITableViewDataSource (outputs) =========================
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        cell = tableViewObjectForTasks.dequeueReusableCellWithIdentifier("DefaultCell")!
        cell.textLabel?.text = tasks[indexPath.row].title
        cell.detailTextLabel?.text = tasks[indexPath.row].details
        return cell
    }
    // ==================================================================

    
    // ==================== UITableViewDelegate (Inputs) ====================
    
    // On Swipe & Delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print("Delete @ \(indexPath.row)")
        print("Delete Element: \(tasks[indexPath.row].objectID)")
        
        managedObjectContext.deleteObject(tasks[indexPath.row])

//        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                tasks.removeAtIndex(indexPath.row)
                print("Success")
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
//        }
        tableViewObjectForTasks.reloadData()

        // Alternate Version
        //        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        //        app.saveContext()
        //        tasks.removeAtIndex(indexPath.row)
        //        tableViewObjectForTasks.reloadData()
        
    }
    // ==================================================================

    
    @IBAction func buttonPressedToAddNewTask(sender: UIButton) {

        let entity = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedObjectContext)
        
        let entityInstance = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        entityInstance.setValue(textFieldForNewTask.text, forKey: "title")
        entityInstance.setValue("DetailsTest", forKey: "details")
        
//        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                tasks.append(entityInstance as! Task)
                print("Success")
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
//        }
        tableViewObjectForTasks.reloadData()
        
    }
    
    // After the view loads
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewObjectForTasks.dataSource = self // UITableViewDataSource == dataSource
        tableViewObjectForTasks.delegate = self // UITableViewDelegate == delegate
    }
    
    // After the view appears
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let taskRequest = NSFetchRequest(entityName: "Task")
        do {
            let fetchedEntities = try self.managedObjectContext.executeFetchRequest(taskRequest)
            tasks = fetchedEntities as! [Task]
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
        tableViewObjectForTasks.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

