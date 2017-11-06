//
//  MoreDetailTableViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/3/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit

class MoreDetailTableViewController: UITableViewController {

    var Values = [0.0]
    var sensorType = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
        
        
        let collectedAcceleration = Values[indexPath.row]
        
        if sensorType == "Accel"
        {
        if abs(Values[indexPath.row]) >= 5
        {
            cell.textLabel?.textColor = UIColor.green
        }
        else
        {
            cell.textLabel?.textColor = UIColor.black
        }
        }
        
        else {
            cell.textLabel?.textColor = UIColor.black
        }
        
        cell.textLabel?.text? = String(collectedAcceleration)
        
        
        return cell
    }
    

}
