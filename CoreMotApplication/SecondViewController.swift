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
    
    let motionManager = CMMotionManager()
    let interval = 0.1
    var motionTimer : Timer?
    var calAvgX = 0.0
    var calAvgY = 0.0
    var calAvgZ = 0.0
    var runningAveragex = 0.0
    var runningAveragey = 0.0
    var runningAveragez = 0.0
    var xAcceleration = 0.0
    var yAcceleration = 0.0
    var zAcceleration = 0.0
    var i = Array(0...100)
    var xValues = [0.0]
    var yValues = [0.0]
    var zValues = [0.0]
    
    @IBOutlet weak var Calibrate: UIProgressView!
    
    
    // This class is used as the starting point for getting accelerometer data.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func CalibrateData(_ sender: Any) {
    
                for sample in i
                {
                    
                    if motionManager.isDeviceMotionAvailable, #available(iOS 10.0, *)  {
                        
                        //prime motion variables
                        self.motionSetup()
                        
                        // start getting motion data
                        self.startMotionTimer()
                    } else {
                        // pop up with error
                        presentAlert(title: "Error", message: "Device Motion is not available.")
                    }
                    
                    
                    
                    if let data = self.motionManager.deviceMotion {
                        
                        self.xValues.insert((self.runningAveragex + (data.userAcceleration.x * 9.81)), at: 0)
                        self.yValues.insert((self.runningAveragey + (data.userAcceleration.y * 9.81)), at: 0)
                         self.zValues.insert((self.runningAveragez + (data.userAcceleration.z * 9.81)), at: 0)
                        
                    }
                    
                    if sample == 100
                    {
                        calAvgX = runningAveragex / 100
                        calAvgY = runningAveragey / 100
                        calAvgZ = runningAveragez / 100
                        
                        print()
                        
                        self.motionManager.stopDeviceMotionUpdates()
                        self.motionTimer?.invalidate()
                    }
                    
                }
        

        // Progress Bar based upon i
        
        
        
    //RunLoop.current.add(self.motionTimer!, forMode: .defaultRunLoopMode)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

// When segue is called within the storyboard, it segues to the acceleration table view.
        let destVC = segue.destination as! AccelerationTableViewController
// Depending on the button that is selected in the storyboard, the appropriate title will be sent to AccelerationTableViewController to be used as the navigation title.
        let buttonSelected = segue.identifier
        destVC.buttonSelected = buttonSelected.self!
        destVC.calAvgX = calAvgX.self
        destVC.calAvgY = calAvgX.self
        destVC.calAvgZ = calAvgX.self
    
       
        
    }
    
    @IBAction func unwindToAccel(segue:UIStoryboardSegue) {}
}
