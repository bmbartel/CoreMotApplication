//
//  AccelerationTableViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 10/30/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit
import CoreMotion

// This is the controller that didn't initially upload.

class AccelerationTableViewController: UITableViewController {
    // Defining variables. motionManager needs to be setup so that we can call it later in the code.
    let motionManager = CMMotionManager()
    var buttonSelected = ""
    var chosenAccelUnit = 0.0
    var accelUnitType = ""
    let interval = 0.1
    var motionTimer : Timer?
    
    // If the current value changes, and the count is less than 100, it will reload the data. If it is equal to 100, then the array is full and it will segue to MoreDetail: Just showing the last 100 values in an alternate view.
    var currentValue = [0.0] {
        didSet {
            if currentValue.count < 100
            {
                tableView.reloadData()
            }
            if currentValue.count == 100
            {
                performSegue(withIdentifier: "MoreDetail", sender: self)
            }
        }
    }
    
    // Setup motion. Utilizing same method as in class.
    func motionSetup() {
        // tell the device to update motion data every second
        motionManager.deviceMotionUpdateInterval = self.interval
        
        // if calibration is required, show the movement display
        motionManager.showsDeviceMovementDisplay = true
    }
    // Starting the motion timer in the same manner as in class.
    func startMotionTimer()
    {
        // tell the device to start updating motion data
        self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
        
        // check for timer in progress
        if motionTimer != nil {
            motionTimer!.invalidate()
        }
        
        // create and start timer with handler block that updates labels in the view
        if #available(iOS 10.0, *) {
            self.motionTimer = Timer(fire: Date(), interval: self.interval, repeats: true, block: {(motionTimer) in
                // This switch statement makes it so that we insert the acceleration value, in m/s^2, to the array. This value will be x,y, or z dependent on the buttonSelected on the previous view.
                if let data = self.motionManager.deviceMotion {
                    switch self.buttonSelected {
                    case "X Accel":
                        self.currentValue.insert((data.userAcceleration.x * 9.81) * self.chosenAccelUnit, at: 0)
                    case "Y Accel":
                        self.currentValue.insert((data.userAcceleration.y * 9.81) * self.chosenAccelUnit, at: 0)
                    case "Z Accel":
                        self.currentValue.insert((data.userAcceleration.z * 9.81) * self.chosenAccelUnit, at: 0)
                    default:
                        print("Missed Value")
                    }
                }
            }
            )
        } else {
            // Fallback on earlier versions
        }
        
        
        
        
        // add the timer to our run loop
        RunLoop.current.add(self.motionTimer!, forMode: .defaultRunLoopMode)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This line updates the navigation title to the button selected on the previous view.
        navigationItem.title = buttonSelected
        
        
    }
    
    // Same as used in class. This will bein the motion manager as soon as the view appears, so long as device COREmotion is available.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // check if we're able to sense device motion
         if motionManager.isDeviceMotionAvailable, #available(iOS 10.0, *)  {
            //prime motion variables
            self.motionSetup()
            
            // start getting motion data
            self.startMotionTimer()
        } else {
            // pop up with error
            presentAlert(title: "Error", message: "Device Motion is not available.")
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        // stop timer and motion updates if navigating away from view
        if motionTimer != nil {
            motionTimer!.invalidate()
        }
        
        // Stop the device motion updates as soo as the view goes away (segue occured).
        self.motionManager.stopDeviceMotionUpdates()
        
        super.viewDidDisappear(true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Function for presenting the alert.
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Plot the total number of values in the array.
        return currentValue.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        
        // Create a new variable that takes the current valye at the current indexPath row
        let accelerations = currentValue[indexPath.row]
        
        // Setting threshold for the current value. If the acceleration is greater than or equal to 5 m/s^2, then the phone is definitely in motion.
        if abs(currentValue[indexPath.row]) >= 5
        {
            cell.textLabel?.textColor = UIColor.green
        }
        else
        {
            cell.textLabel?.textColor = UIColor.black
        }
        
        // Send the value to the text of the cell.
        cell.textLabel?.text? = String(accelerations)
        
        
        return cell
        
    }
    
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let SplitVC = segue.destination as! MoreDetailTableViewController
        // Send the values in this table view to a segued view. Currently this added view doesn't hold much value. But moving forward, it could be used for data manipulation (i.e. trying to calculate distance). Potentially for the final project.
       
        SplitVC.Values = Array(currentValue.self.reversed())
        SplitVC.sensorType = "Accel"
        SplitVC.buttonSelected = self.buttonSelected
//        SplitVC.accelUnitType = accelUnitType.self
        // Stop the motion manager updates once segue has occured.
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    
}
