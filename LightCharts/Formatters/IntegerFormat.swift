//
//  IntegerFormat.swift
//  LightCharts
//
//  Created by Leonardo Geus on 23/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Charts

public class IntegerFormatter: NSObject, IValueFormatter {
    
    public func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        return String(format: "%.0f", value)
        
    }
    
}

