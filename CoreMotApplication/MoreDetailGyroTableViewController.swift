//
//  MoreDetailGyroTableViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/22/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit

// This view controller will display acceleration(x,y,z) or gyro(roll,pitch,yaw) depending on what the user has navigated to. In this controller, moving forward for the final project, we could attempt to make plots. Potentially change this to a split view controller. And could perform data manipulation to try to estimate distance from acceleration values.

class MoreDetailGyroTableViewController: UITableViewController {
    
    // Initialize variables, so that we can pass values over from the previous views.
    var Values = [0.0]
    var sensorType = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Maybe conditionally add a button: If the acceleration values are the values being looked at, add a button entitled (Estimate Distance). Then this button will Segue to another view which will plot and display the distance estimates (Split View Controller). Add this button as soon as the program loads. And set-up a performsegue function for this button.
        
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
