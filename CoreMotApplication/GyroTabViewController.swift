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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let destVC = segue.destination as! GyroTableViewController
        
        let buttonSelected = segue.identifier
        destVC.buttonSelected = buttonSelected.self!
        
}
}
