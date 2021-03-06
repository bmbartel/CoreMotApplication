//
//  SecondViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 10/29/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit
import CoreMotion

class SecondViewController: UIViewController {
    
    var chosenAccelUnit = 9.81
    var accelUnitType = "m/s²"
    let motionManager = CMMotionManager()
    let interval = 0.1
    var motionTimer : Timer?
    var calAvgX = 0.0
    var calAvgY = 0.0
    var calAvgZ = 0.0
    var runningAveragex = 0.0
    var runningAveragey = 0.0
    var runningAveragez = 0.0
    var xValues = [0.0]
    var yValues = [0.0]
    var zValues = [0.0]
    var totalX = 0.0
    var totalY = 0.0
    var totalZ = 0.0
    
    @IBOutlet weak var metersPerSecChosen: UIButton!
    @IBOutlet weak var centimetersPerSecChosen: UIButton!
    @IBOutlet weak var feetPerSecChosen: UIButton!
    @IBOutlet weak var inchesPerSecChosen: UIButton!
    
    @IBOutlet weak var Calibrate: UIProgressView!
    
    
    // This class is used as the starting point for getting accelerometer data.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        metersPerSecChosen.backgroundColor = UIColor.lightGray
        centimetersPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        feetPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        inchesPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func metersPerSecChosen(_ sender: UIButton) {
        chosenAccelUnit = 9.81
        accelUnitType = "m/s²"
        metersPerSecChosen.backgroundColor = UIColor.lightGray
        centimetersPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        feetPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        inchesPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
    }
    @IBAction func centimetersPerSecChosen(_ sender: UIButton) {
        chosenAccelUnit = 981
        accelUnitType = "cm/s²"
        metersPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        centimetersPerSecChosen.backgroundColor = UIColor.lightGray
        feetPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        inchesPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
    }
    @IBAction func feetPerSecChosen(_ sender: UIButton) {
        chosenAccelUnit = 32.18503937
        accelUnitType = "ft/s²"
        metersPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        centimetersPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        feetPerSecChosen.backgroundColor = UIColor.lightGray
        inchesPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
    }
    @IBAction func inchesPerSecChosen(_ sender: UIButton) {
        chosenAccelUnit = 386.2204764
        accelUnitType = "in/s²"
        metersPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        centimetersPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        feetPerSecChosen.backgroundColor = UIColor.groupTableViewBackground
        inchesPerSecChosen.backgroundColor = UIColor.lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // check if we're able to sense device motion
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
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
//         tell the device to start updating motion data
        self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)

        // check for timer in progress
        
        if motionTimer != nil {
            motionTimer!.invalidate()
        }
 
    }
  
    
    // if button is pressed
    
    @IBAction func CalibrateData(_ sender: UIButton) {
        
        if motionManager.isDeviceMotionAvailable, #available(iOS 10.0, *)  {
            
            //prime motion variables
            self.motionSetup()
            // start getting motion data
            self.startMotionTimer()
        }
            
        else {
            // pop up with error
            presentAlert(title: "Error", message: "Device Motion is not available.")
        }
        
        
        if #available(iOS 10.0, *) {
            self.motionTimer = Timer(fire: Date(), interval: self.interval, repeats: true, block: {(motionTimer) in
                // This switch statement makes it so that we insert the acceleration value, in m/s^2, to the array. This value will be x,y, or z dependent on the buttonSelected on the previous view.
                if let data = self.motionManager.deviceMotion {
                    // Initially make the setProgress bar equal to 0.
                    self.Calibrate.setProgress(Float(0.0), animated: false)
                    
                    self.xValues = [0.0]
                    self.yValues = [0.0]
                    self.zValues = [0.0]
                    while self.xValues.count < 1001
                {
    
                                self.runningAveragex = self.xValues.last!
                            
                        self.xValues.append((self.runningAveragex + (data.userAcceleration.x * 9.81)))
                        self.yValues.append((self.runningAveragey + (data.userAcceleration.y * 9.81)))
                         self.zValues.append((self.runningAveragez + (data.userAcceleration.z * 9.81)))
                    
                    CATransaction.begin()
                    CATransaction.setCompletionBlock({
                    self.Calibrate.setProgress(Float(self.xValues.count/1000), animated: true)
                    })
                    
                    self.Calibrate.setProgress(Float(self.xValues.count * 0), animated: false)
                    CATransaction.commit()
                    
                    // Take the last value of the running sum of accelerations, divide by the number of values in the matrix, we then have the theoretical drift. However, we may still need to implement a delay in here.
                    
                    self.calAvgX = self.xValues.last! / Double(self.xValues.count)
                    self.calAvgY = self.yValues.last! / Double(self.yValues.count)
                    self.calAvgZ = self.zValues.last! / Double(self.zValues.count)
                    
                            }
                    
                        }
                else
                {
                    // Nothing.
                }
            })}
                    
                    // add the timer to our run loop
                    RunLoop.current.add(self.motionTimer!, forMode: .defaultRunLoopMode)
        
                }
    


        // Progress Bar based upon i
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

// When segue is called within the storyboard, it segues to the acceleration table view.
        let destVC = segue.destination as! AccelerationTableViewController
// Depending on the button that is selected in the storyboard, the appropriate title will be sent to AccelerationTableViewController to be used as the navigation title.
        let buttonSelected = segue.identifier
        destVC.buttonSelected = buttonSelected.self!
        destVC.calAvgX = calAvgX.self
        destVC.calAvgY = calAvgX.self
        destVC.calAvgZ = calAvgX.self
        destVC.chosenAccelUnit = self.chosenAccelUnit
        destVC.accelUnitType = self.accelUnitType
    
       
        
    }
    
    @IBAction func unwindToAccel(segue:UIStoryboardSegue) {}
}
