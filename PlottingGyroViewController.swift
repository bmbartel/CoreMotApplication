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
    var xAxis = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100]
    
    
    @IBOutlet weak var GyroLine: JBLineChartView!
    
    @IBOutlet weak var GyroDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.darkGray
 
        GyroLine.backgroundColor = UIColor.darkGray
        GyroLine.delegate = self
        GyroLine.dataSource = self
    // Minimum value has to be 0 or positive. To make this work better, we need to add 180 to all values. I then make the plot fill out the screen by using the min and max values of the array.
        
        GyroLine.minimumValue = CGFloat(Int(Values.min()!))
        GyroLine.maximumValue = CGFloat(Int(Values.max()!+15))
        
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
            let data = Values[Int(horizontalIndex)].rounded()
            let axis = xAxis[Int(horizontalIndex)]
            GyroDataLabel.text = "\(data), on sample number \(axis)"
        }

        
    }
    func didDeselectLine(in lineChartView: JBLineChartView!) {
        GyroDataLabel.text = "Hover Over Point to See Value."
    }
}
