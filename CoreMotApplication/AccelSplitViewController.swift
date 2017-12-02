//
//  AccelSplitViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 12/2/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit

class AccelSplitViewController: UISplitViewController {
    var Values = [0.0]
    var sensorType = ""
    var buttonSelected = ""
    var unitType = "m/s²"
    var absValues = [0.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let navVC = (self.viewControllers.first as! UINavigationController)
        (navVC.viewControllers.first as! MoreDetailTableViewController).Values = self.Values
        // For Plotting we are sending the absolute values of the accelerations. 
        (self.viewControllers.last as! PlottingAccelViewController).Values = self.absValues
        (self.viewControllers.last as! PlottingAccelViewController).unitType = self.unitType
        
        (navVC.viewControllers.first as! MoreDetailTableViewController).buttonSelected = self.buttonSelected
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
