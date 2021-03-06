//
//  PlottingAccelViewController.swift
//  CoreMotApplication
//
//  Created by Brandon on 12/2/17.
//  Copyright © 2017 Arizona State University. All rights reserved.
//

// This plotting method was taught and followed by: https://www.youtube.com/watch?v=hMdMg3mcSCc
// This framework came from: https://github.com/Jawbone/JBChartView
// Modified for our purposes.

import UIKit
import JBChart

// Need a way for the data being sent to the split view controller to be seen in this ploting VC as well as the master table view controller. Also, need to get the UIButton send back feature to work. However, it is not in a navigation view anymore so this may be a problem.

class PlottingAccelViewController: UIViewController, JBLineChartViewDelegate, JBLineChartViewDataSource {
    
    // The values will be brought in when imported
    var Values = [0.0]
    var unitType = ""
    var sensorType = ""
    var color = ""
    // X-Axis is 0 to 100 samples and representative of a 10 second time window.
    var xAxis = [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0,2.1,2.2,2.3,2.4,2.5,2.6,2.7,2.8,2.9,3.0,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,3.9,4.0,4.1,4.2,4.3,4.4,4.5,4.6,4.7,4.8,4.9,5.0,5.1,5.2,5.3,5.4,5.5,5.6,5.7,5.8,5.9,6.0,6.1,6.2,6.3,6.4,6.5,6.6,6.7,6.8,6.9,7.0,7.1,7.2,7.3,7.4,7.5,7.6,7.7,7.8,7.9,8.0,8.1,8.2,8.3,8.4,8.5,8.6,8.7,8.8,8.9,9.0,9.1,9.2,9.3,9.4,9.5,9.6,9.7,9.8,9.9,10.0]


    @IBOutlet weak var AccelLine: JBLineChartView!
    @IBOutlet weak var AccelDataLabel: UILabel!
    
    @IBOutlet weak var grayChosen: UIButton!
    @IBOutlet weak var redChosen: UIButton!
    @IBOutlet weak var yellowChosen: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grayChosen.backgroundColor = UIColor.lightGray
        redChosen.backgroundColor = UIColor.white
        yellowChosen.backgroundColor = UIColor.white
        
        //        let footer = UIView(frame: CGRect.init(x:0, y:0, width:GyroLine.frame.width, height:16))
        //        let footersub1 = UILabel(frame: CGRect.init(x:0, y:0, width:GyroLine.frame.width/2-8, height:16))
        //        footersub1.textColor = UIColor.white
        //        footersub1.text = "\(xAxis[0])"
        //
        //        let footersub2 = UILabel(frame: CGRect.init(x:GyroLine.frame.width/2 - 8, y:0, width:GyroLine.frame.width/2 - 8, height:16))
        //        footersub2.textColor = UIColor.white
        //        footersub2.text = "\(xAxis[xAxis.count - 1])"
        //        footersub2.textAlignment = NSTextAlignment.right
        //
        //        footer.addSubview(footersub1)
        //        footer.addSubview(footersub2)
        //
        //        let header = UILabel(frame: CGRect.init(x:0, y:0, width:GyroLine.frame.width, height:50))
        //        header.textColor = UIColor.white
        //        header.text = "Gyro Values"
        //        header.font = UIFont.systemFont(ofSize: 24)
        //        header.textAlignment = NSTextAlignment.center
        //
        //        GyroLine.footerView = footer
        //        GyroLine.headerView = header
        
        view.backgroundColor = UIColor.darkGray
        AccelLine.backgroundColor = UIColor.darkGray
        AccelLine.delegate = self
        AccelLine.dataSource = self
        // Minimum value has to be 0 or positive. To make this work better, we need to add 180 to all values. I then make the plot fill out the screen by using the min and max values of the array.
        
        AccelLine.minimumValue = CGFloat(Int(Values.min()!))
        AccelLine.maximumValue = CGFloat(Int(Values.max()!+15))
        
        AccelLine.setState(.collapsed, animated: false)
}


    @IBAction func grayChosen(_ sender: UIButton) {
    grayChosen.backgroundColor = UIColor.lightGray
    redChosen.backgroundColor = UIColor.white
    yellowChosen.backgroundColor = UIColor.white
    color = "gray"
    }
    
    
    @IBAction func redChosen(_ sender: UIButton) {
    grayChosen.backgroundColor = UIColor.white
    redChosen.backgroundColor = UIColor.red
    yellowChosen.backgroundColor = UIColor.white
    color = "red"
    }
    
    @IBAction func yellowChosen(_ sender: UIButton) {
    grayChosen.backgroundColor = UIColor.white
    redChosen.backgroundColor = UIColor.white
    yellowChosen.backgroundColor = UIColor.yellow
    color = "yellow"
    }



    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AccelLine.reloadData()
        AccelLine.setState(.expanded, animated: true)
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AccelLine.setState(.collapsed, animated: true)
    }
    

    // If the device orientation changes, reset the state of the plot. -> Doesn't work yet..
    // Below concept for viewWillTransition applied and manipulated from: https://stackoverflow.com/questions/25666269/how-to-detect-orientation-change
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            AccelLine.reloadData()
            self.viewDidLoad()
            self.viewDidAppear(true)
            AccelLine.setState(.expanded, animated: true)
            
        }
        else {
            AccelLine.reloadData()
            self.viewDidLoad()
            self.viewDidAppear(true)
            AccelLine.setState(.expanded, animated: true)
        }
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
            if (color == "gray") {
                return UIColor.lightGray
            }
            else if (color == "red") {
                return UIColor.red
            }
            else if (color == "yellow") {
                return UIColor.yellow
            }
            else {
                return UIColor.lightGray
            }
        }
        else {
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
            AccelDataLabel.text = "\(data) \(unitType) at \(axis) seconds"
        }
        
        
    }
    func didDeselectLine(in lineChartView: JBLineChartView!) {
        AccelDataLabel.text = "Hover over point to see value and chosen color!"
    }
}


