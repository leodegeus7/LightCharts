//
//  TimeStampFormatter.swift
//  LightCharts
//
//  Created by Leonardo Geus on 22/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Charts

class TimeStampFormatter: NSObject,IAxisValueFormatter {
    
    var xLabel = [Double]()
    var formatter:DateFormatter!
    
    public init(xLabel:[Double],formatter:DateFormatter) {
        self.xLabel = xLabel
        self.formatter = formatter
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if Int(value) < xLabel.count {
            let timeStamp = xLabel[Int(value)]
            let date = Date(timeIntervalSince1970: timeStamp)
            let string = formatter.string(from: date)
            return string
        } else {
            return ""
        }
    }
}
