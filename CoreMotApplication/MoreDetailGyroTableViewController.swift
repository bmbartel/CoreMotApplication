//
//  MoreDetailGyroTableViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/22/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit
import CoreData

// This view controller will display acceleration(x,y,z) or gyro(roll,pitch,yaw) depending on what the user has navigated to. In this controller, moving forward for the final project, we could attempt to make plots. Potentially change this to a split view controller. And could perform data manipulation to try to estimate distance from acceleration values.

class MoreDetailGyroTableViewController: UITableViewController {
    
    // Initialize variables, so that we can pass values over from the previous views.
    var Values = [0.0]
    var sensorType = ""
    var buttonSelected = ""
    var valuesToSend = [0.0]
    var conditional = false
    
    
    @IBAction func GoBack(_ sender: Any) {
        performSegue(withIdentifier: "UnwindToGyro", sender: self)
    }
    
   
    
    @IBAction func saveButton(_ sender: Any) {
        // print(Variables.nameValuesToSend)
        if conditional == false {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newSession = NSEntityDescription.insertNewObject(forEntityName: "Data", into: context)
        let newFinalSession = NSEntityDescription.insertNewObject(forEntityName: "AllData", into: context)
        
        
            
            //Variables.nameValue = Variables.nameValue + 1
            
            Variables.nameValuesToSend.insert(Variables.nameValue, at: 0)
            Variables.finalValues.insert(Values, at: 0)
            
            
            
            newSession.setValue(Values, forKey: "data")
            newSession.setValue(Variables.nameValuesToSend, forKey: "name")
            newFinalSession.setValue(Variables.finalValues, forKey: "allData")
            Variables.nameValue = Variables.nameValue + 1
            
            do {
                try context.save()
            } catch {
                print("failed to save")
            }
            
            conditional = true
            
    }
    else {
        print("You suck")
    }
    
    }
            
    

    
    override func viewDidLoad() {
        // super.viewDidLoad()
        
        // Maybe conditionally add a button: If the acceleration values are the values being looked at, add a button entitled (Estimate Distance). Then this button will Segue to another view which will plot and display the distance estimates (Split View Controller). Add this button as soon as the program loads. And set-up a performsegue function for this button.
        navigationItem.title = buttonSelected
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Values.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "value", for: indexPath)
        
        // Configure the cell...
        
        
        let collectedGyro = Values[indexPath.row]
        
        // Only utilize the thresholding functionality in this tab if we are looking at the accelerometer values. The gyro values will always plot in black.
        
        
        cell.textLabel?.text? = String(collectedGyro)
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // If we add a segue here.
    }
    
    
}


