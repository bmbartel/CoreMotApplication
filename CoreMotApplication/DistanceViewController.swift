//
//  DistanceViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/19/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit

class DistanceViewController: UITableViewController {

    var accelerations = [0.0] {
    didSet {
        let DistanceMatrix = accelerations.enumerated().forEach { index, value in accelerations[index] = abs(value)/100.0 }
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
