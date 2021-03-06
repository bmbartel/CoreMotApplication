//
//  DistanceTableTableViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/19/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit

class DistanceTableViewController: UITableViewController {

    var accelerations = [0.0]
    var LastDistanceValue = 0.0
    var distanceValues = [Double]()
    var calAvgX = 0.0
    var calAvgY = 0.0
    var calAvgZ = 0.0
    var buttonSelected = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in accelerations
        {
            
            switch self.buttonSelected {
            case "X Accel":
            let tempValue = abs(i-calAvgX)/100.0 + LastDistanceValue
            distanceValues.append(tempValue)
            LastDistanceValue = tempValue
            case "Y Accel":
                let tempValue = abs(i-calAvgY)/100.0 + LastDistanceValue
                distanceValues.append(tempValue)
                LastDistanceValue = tempValue
            case "Z Accel":
              let tempValue = abs(i-calAvgZ)/100.0 + LastDistanceValue
              distanceValues.append(tempValue)
              LastDistanceValue = tempValue
            default:
                print("Missed Value")
            
        }
    }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return accelerations.count
 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceView", for: indexPath)

        // Do absolute value of distance to calculate distance when accelerating and deaccelerating. Also, divide by 100. This is essentially a double integration. Dividing each sample by its sampling rate (10Hz) twice. Then doing a running total of these values to get distance.
        
        // If we were to add a calibration, we would subtract out the value from the calibration from each of the acceleration values in the below equation. Could make slightly more accurate. 
        

        
        // Multiply by 39.3701 to convert a meter value to inches.
        cell.textLabel?.text? = String(distanceValues[indexPath.row] * 39.3701)
        
        return cell
    }


}
