//
//  StringFormatter.swift
//  DemoApp
//
//  Created by Leonardo Geus on 16/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Charts

public class MyValueFormatter: NSObject, IAxisValueFormatter {
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(value)"
    }
}
