//
//  SecondViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 10/29/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit

// In this view controller, the user is able to select
class SecondViewController: UIViewController {
    
    var chosenAccelUnit = 0.0
    var accelUnitType = ""
    
    @IBOutlet weak var metersPerSecChosen: UIButton!
    @IBOutlet weak var centimetersPerSecChosen: UIButton!
    @IBOutlet weak var feetPerSecChosen: UIButton!
    @IBOutlet weak var inchesPerSecChosen: UIButton!
    
// This class is used as the starting point for getting accelerometer data.
    override func viewDidLoad() {
        super.viewDidLoad()
        metersPerSecChosen.backgroundColor = UIColor.darkGray
        centimetersPerSecChosen.backgroundColor = UIColor.lightGray
        feetPerSecChosen.backgroundColor = UIColor.lightGray
        inchesPerSecChosen.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func metersPerSecChosen(_ sender: UIButton) {
        chosenAccelUnit = 1.0
        accelUnitType = "Meters"
        metersPerSecChosen.backgroundColor = UIColor.darkGray
        centimetersPerSecChosen.backgroundColor = UIColor.lightGray
        feetPerSecChosen.backgroundColor = UIColor.lightGray
        inchesPerSecChosen.backgroundColor = UIColor.lightGray
    }
    @IBAction func centimetersPerSecChosen(_ sender: UIButton) {
        chosenAccelUnit = 100
        accelUnitType = "Centimeters"
        metersPerSecChosen.backgroundColor = UIColor.lightGray
        centimetersPerSecChosen.backgroundColor = UIColor.darkGray
        feetPerSecChosen.backgroundColor = UIColor.lightGray
        inchesPerSecChosen.backgroundColor = UIColor.lightGray
    }
    @IBAction func feetPerSecChosen(_ sender: UIButton) {
        chosenAccelUnit = 3.280839895013
        accelUnitType = "Feet"
        metersPerSecChosen.backgroundColor = UIColor.lightGray
        centimetersPerSecChosen.backgroundColor = UIColor.lightGray
        feetPerSecChosen.backgroundColor = UIColor.darkGray
        inchesPerSecChosen.backgroundColor = UIColor.lightGray
    }
    @IBAction func inchesPerSecChosen(_ sender: UIButton) {
        chosenAccelUnit = 39.3700787401
        accelUnitType = "Inches"
        metersPerSecChosen.backgroundColor = UIColor.lightGray
        centimetersPerSecChosen.backgroundColor = UIColor.lightGray
        feetPerSecChosen.backgroundColor = UIColor.lightGray
        inchesPerSecChosen.backgroundColor = UIColor.darkGray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

// When segue is called within the storyboard, it segues to the acceleration table view.
        let destVC = segue.destination as! AccelerationTableViewController
// Depending on the button that is selected in the storyboard, the appropriate title will be sent to AccelerationTableViewController to be used as the navigation title.
        let buttonSelected = segue.identifier
        destVC.buttonSelected = buttonSelected.self!
        destVC.chosenAccelUnit = self.chosenAccelUnit
        destVC.accelUnitType = self.accelUnitType
        
    }
    
    @IBAction func unwindToAccel(segue:UIStoryboardSegue) {}
}
