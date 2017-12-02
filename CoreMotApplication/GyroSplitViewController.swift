//
//  GyroSplitViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/22/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit

class GyroSplitViewController: UISplitViewController {
    var Values = [0.0]
    var sensorType = ""
    var buttonSelected = ""
    var unitType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let navVC = (self.viewControllers.first as! UINavigationController)
        (navVC.viewControllers.first as! MoreDetailGyroTableViewController).Values = self.Values
        (self.viewControllers.last as! PlottingGyroViewController).Values = self.Values
        (self.viewControllers.last as! PlottingGyroViewController).unitType = self.unitType
        
        (navVC.viewControllers.first as! MoreDetailGyroTableViewController).buttonSelected = self.buttonSelected
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
