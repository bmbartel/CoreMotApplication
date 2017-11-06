//
//  SecondViewController.swift
//  coreMotion
//
//  Created by Brandon on 10/29/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
// This class is used as the starting point for getting accelerometer data.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

// When segue is called within the storyboard, it segues to the acceleration table view.
        let destVC = segue.destination as! AccelerationTableViewController
// Depending on the button that is selected in the storyboard, the appropriate title will be sent to AccelerationTableViewController to be used as the navigation title.
        let buttonSelected = segue.identifier
        destVC.buttonSelected = buttonSelected.self!
        
        
    }
}
