//
//  StringFormatter.swift
//  LightCharts
//
//  Created by Leonardo Geus on 20/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Charts

public class StringFormatter: NSObject,IAxisValueFormatter {
    
    var xLabel = [String]()
    
    public init(xLabel:[String]) {
        self.xLabel = xLabel
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        print(value)
        if Int(value) < xLabel.count {
            return xLabel[Int(value)]
        } else {
            return ""
        }
    }
}
