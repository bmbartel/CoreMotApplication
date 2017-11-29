//
//  GyroTableViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/5/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//


import UIKit
import CoreMotion

// This view controller does essentially the same thing as the acceleration table view controller. However, it displays rotational values (degrees).

class GyroTableViewController: UITableViewController {
    
    let motionManager = CMMotionManager()
    var buttonSelected = ""
    let interval = 0.1
    var motionTimer : Timer?
    var currentValue = [0.0] {
        didSet {
            if currentValue.count < 100
            {
                tableView.reloadData()
            }
            if currentValue.count == 100
            {
                performSegue(withIdentifier: "MoreDetailGyro", sender: self)
            }
        }
    }
    
    func motionSetup() {
        // tell the device to update motion data every second
        motionManager.deviceMotionUpdateInterval = self.interval
        
        // if calibration is required, show the movement display
        motionManager.showsDeviceMovementDisplay = true
    }
    
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
                if let data = self.motionManager.deviceMotion {
                    switch self.buttonSelected {
                    case "Pitch":
                        self.currentValue.insert(data.attitude.pitch * 180/Double.pi, at: 0)
                    case "Roll":
                        self.currentValue.insert(data.attitude.roll * 180/Double.pi, at: 0)
                    case "Yaw":
                        self.currentValue.insert(data.attitude.yaw * 180/Double.pi, at: 0)
                    default:
                        print("Missed Value")
                    }
                }
            }
            )
        } else {
            presentAlert(title: "Error", message: "Device Motion is not available.")
        }
        
        
        
        
        // add the timer to our run loop
        RunLoop.current.add(self.motionTimer!, forMode: .defaultRunLoopMode)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        navigationItem.title = buttonSelected
        
        
    }
    
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
        
        self.motionManager.stopDeviceMotionUpdates()
        
        super.viewDidDisappear(true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
        
        
        let rotationValues = currentValue[indexPath.row]
        
        cell.textLabel?.text? = String(rotationValues)
        
        
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
        let SplitVC = segue.destination as! GyroSplitViewController
        SplitVC.sensorType = "Gyro"
        SplitVC.Values = self.currentValue
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    
}
