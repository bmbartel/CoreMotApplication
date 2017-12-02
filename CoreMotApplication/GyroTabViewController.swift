//
//  GyroTabViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/5/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit


// This is essentially the same as SecondViewController, However, this prepares for the gyro data.
class GyroTabViewController: UIViewController {
    
    var chosenUnit = 1.0
    var unitType = "degrees"

    @IBOutlet weak var degreeChosen: UIButton!
    @IBOutlet weak var radianChosen: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        degreeChosen.backgroundColor = UIColor.darkGray
        radianChosen.backgroundColor = UIColor.lightGray
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func degreeChosen(_ sender: UIButton) {
        chosenUnit = 1.0
        unitType = "degrees"
        degreeChosen.backgroundColor = UIColor.darkGray
        radianChosen.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func radianChosen(_ sender: UIButton) {
        chosenUnit = 0.017453292519
        unitType = "radians"
        degreeChosen.backgroundColor = UIColor.lightGray
        radianChosen.backgroundColor = UIColor.darkGray
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destVC = segue.destination as! GyroTableViewController
        
        let buttonSelected = segue.identifier
        destVC.buttonSelected = buttonSelected.self!
        destVC.chosenUnit = self.chosenUnit
        destVC.unitType = self.unitType
        
}
    @IBAction func unwindToGyro(segue:UIStoryboardSegue) {}
}
