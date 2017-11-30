//
//  PlottingGyroViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/22/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit
import JBChart

// Need a way for the data being sent to the split view controller to be seen in this ploting VC as well as the master table view controller. Also, need to get the UIButton send back feature to work. However, it is not in a navigation view anymore so this may be a problem.

class PlottingGyroViewController: UIViewController, JBLineChartViewDelegate, JBLineChartViewDataSource {

    // The values will be brought in when imported
    var Values = [0.0]
    var sensorType = ""
    // X-Axis is 0 to 100 samples.
    var xAxis = [1.0...100.0]
    
    
    @IBOutlet weak var GyroLine: JBLineChartView!
    
    @IBOutlet weak var GyroDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.darkGray
 
        GyroLine.backgroundColor = UIColor.darkGray
        GyroLine.delegate = self
        GyroLine.dataSource = self
    // Minimum value has to be 0 or positive. To make this work better, we need to add 180 to all values.
        
        GyroLine.minimumValue = CGFloat(Int(Values.min()!)+5)
        GyroLine.maximumValue = CGFloat(Int(Values.max()!))
        
        GyroLine.setState(.collapsed, animated: false)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        GyroLine.reloadData()
        GyroLine.setState(.expanded, animated: true)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GyroLine.setState(.collapsed, animated: true)
    }

    

// Begin following added protocols.
    func lineChartView(_ lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        if (lineIndex == 0) {
            return UInt(Values.count)
        }
        else
        {
            return 0
        }
    }
    
    func numberOfLines(in lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex:UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        if (lineIndex == 0) {
        return CGFloat(Values[Int(horizontalIndex)])
    }
        else
        {
            return 0
        }
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        if (lineIndex == 0) {
            return UIColor.lightGray
        }
        else
        {
            return UIColor.lightGray
        }
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return false
    }
    
    func lineChartView(_ lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.lightGray
    }
    func lineChartView(_ lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }

    func lineChartView(_ lineChartView: JBLineChartView!, didSelectLineAt lineIndex: UInt, horizontalIndex: UInt) {
        if (lineIndex == 0) {
            let data = Values[Int(horizontalIndex)]
            let axis = xAxis[Int(horizontalIndex)]
            GyroDataLabel.text = "\(data), on sample number \(axis)"
        }

        
    }
    func didDeselectLine(in lineChartView: JBLineChartView!) {
        GyroDataLabel.text = "Hover Over Point to See Value."
    }
}
