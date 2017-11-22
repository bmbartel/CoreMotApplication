//
//  PlottingGyroViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 11/22/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

import UIKit
import JBChart

class PlottingGyroViewController: UIViewController, JBLineChartViewDelegate, JBLineChartViewDataSource {

    // The values will be brought in when imported
    var Values = [0.0]
    var sensorType = ""
    // X-Axis is 0 to 100 samples.
    var xAxis = [0...100]
    
    
    @IBOutlet weak var GyroLine: JBLineChartView!
    
    @IBOutlet weak var GyroDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blue
 
        GyroLine.backgroundColor = UIColor.blue
        GyroLine.delegate = self
        GyroLine.dataSource = self
        GyroLine.minimumValue = -360
        GyroLine.maximumValue = 360
        
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
        return true
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
        }
        GyroDataLabel.text = String(describing: Values)
    }
    func didDeselectLine(in lineChartView: JBLineChartView!) {
        GyroDataLabel.text = ""
    }
}
