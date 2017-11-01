//
//  SecondViewController.swift
//  coreMotion
//
//  Created by Brandon on 10/29/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


        let destVC = segue.destination as! AccelerationTableViewController
        
        let buttonSelected = segue.identifier
        destVC.buttonSelected = buttonSelected.self!
        
        
    }
}
