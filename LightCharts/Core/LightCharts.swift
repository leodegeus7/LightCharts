//
//  LightCharts.swift
//  LightCharts
//
//  Created by Leonardo Geus on 09/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Charts

public enum GraphType  {
    case Bar
    case Line
    case Pie
    case Radar
}

public class LightCharts: NSObject {
    var view:UIView!
    var type:GraphType!
    var series:[SerieProtocol]!
    var xLabel:[String]!
    var dataEntry: [BarChartDataEntry] = []
    
    var chartView:ChartViewBase!
    
    public var legend:Legend!
    private var config:ChartConfigProtocol!
    
    
    public init(graph:UIView,config:ChartConfigProtocol,serie:SerieProtocol,xLabel:[String]) {
        super.init()
        self.view = graph
        self.config = config
        self.series = []
        self.series.append(serie)
        self.xLabel = xLabel
        setType(config: config)
    }
    
    public init(graph:UIView,config:ChartConfigProtocol,series:[SerieProtocol],xLabel:[String]) {
        super.init()
        self.view = graph
        self.series = series
        self.xLabel = xLabel
        self.config = config
        setType(config: config)
    }
    
    private func setType (config:ChartConfigProtocol) {
        if let _ = config as? PieChartConfig {
            type = .Pie
        } else if let _ = config as? LineChartConfig {
            type = .Line
        } else if let _ = config as? BarChartConfig {
            type = .Bar
        } else if let _ = config as? RadarChartConfig {
            type = .Radar
        }
    }
    
    public func plot() {
        if let pie = config as? PieChartConfig {
            plotPieChart(config: pie)
        } else if let line = config as? LineChartConfig {
            plotLineChart(config: line)
        } else if let bar = config as? BarChartConfig {
            plotBarChart(config: bar)
        } else if let radar = config as? RadarChartConfig {
            plotRadarChart(config: radar)
        }
    }
    
    internal func changeXLabelAngle(xAxis:XAxis) {
        if let two = config as? TwoDimensionGraphProtocol {
            switch two.xLabelAngle {
            case .a0:
                xAxis.labelRotationAngle = 0
            case .a45:
                xAxis.labelRotationAngle = 45
            case .a90:
                xAxis.labelRotationAngle = 90
            case .a135:
                xAxis.labelRotationAngle = 135
            case .Custom(let value):
                xAxis.labelRotationAngle = CGFloat(value)
            }
        }
    }
    
    internal func changeAxisFont(axisConfig:DrawAxis?,axis:AxisBase) {
        
        if let config = axisConfig {
            switch config {
            case .True(let font, let color, let grid):
                if let f = font {
                    switch f {
                    case .Small:
                        axis.labelFont = UIFont.systemFont(ofSize: 10)
                    case .Medium:
                        axis.labelFont = UIFont.systemFont(ofSize: 13)
                    case .Large:
                        axis.labelFont = UIFont.systemFont(ofSize: 16)
                    case .Custom(let font2):
                        axis.labelFont = font2
                    }
                }
                if let c = color {
                    axis.labelTextColor = c
                }
                if let g = grid {
                    axis.drawGridLinesEnabled = g
                }
                axis.enabled = true
                break
            case .False:
                axis.enabled = false
                break
            }
        }
    }
    
    
    internal func changeRadarAxisFont(axisConfig:DrawRadarAxis?,axis:AxisBase) {
        
        if let config = axisConfig {
            switch config {
            case .True(let font, let color):
                if let f = font {
                    switch f {
                    case .Small:
                        
                        axis.labelFont = UIFont.systemFont(ofSize: 10)
                    case .Medium:
                        axis.labelFont = UIFont.systemFont(ofSize: 13)
                    case .Large:
                        axis.labelFont = UIFont.systemFont(ofSize: 16)
                    case .Custom(let font2):
                        axis.labelFont = font2
                    }
                }
                if let c = color {
                    axis.labelTextColor = c
                }
                axis.enabled = true
                break
            case .False:
                axis.enabled = false
                break
            }
        }
    }
    
    public func saveToGallery() {
        
        UIImageWriteToSavedPhotosAlbum(chartView.getChartImage(transparent: false)!, self,  #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            print("Error to save image in gallery: \(error)")
        } else {
            print("Image saved with sucess")
        }
    }
    
    internal func changeEntriesFont(size:FontSize?,dataSet:ChartData) {
        
        if let font = size {
            switch font {
            case .Small:
                dataSet.setValueFont(UIFont.systemFont(ofSize: 8))
            case .Medium:
                dataSet.setValueFont(UIFont.systemFont(ofSize: 10))
            case .Large:
                dataSet.setValueFont(UIFont.systemFont(ofSize: 12))
            case .Custom(let font2):
                dataSet.setValueFont(font2)
            }
        }
    }
    
    internal func calculateLabelInAxisSize(config:TwoDimensionGraphProtocol) -> CGFloat {
        var majorSizeOfLabels:CGFloat = 0
        
        switch config.xLabelFormatter {
        case .String:
            for labelString in xLabel {
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
                label.text = labelString
                let contentSize = label.sizeThatFits(label.bounds.size)
                let higntcons = contentSize.width
                if majorSizeOfLabels < higntcons {
                    majorSizeOfLabels = higntcons
                }
            }
        case .Date(let stringFormatter):
            let formatter = DateFormatter()
            if let form = stringFormatter {
                formatter.dateFormat = form
            } else {
                formatter.dateFormat = "MMM dd ha"
            }
            
            for labelString in xLabel {
                var timeStamp = 0
                if let time = Int(labelString) {
                    timeStamp = time
                } else {
                    print("Wrong value in array to transform in date foramatter, 0 will replace")
                }
                let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
                let string = formatter.string(from: date)
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
                label.text = string
                let contentSize = label.sizeThatFits(label.bounds.size)
                let higntcons = contentSize.width
                if majorSizeOfLabels < higntcons {
                    majorSizeOfLabels = higntcons
                }
            }
        }
        
        
        var angleValue:CGFloat = 0
        switch config.xLabelAngle {
        case .a0:
            angleValue = 0
            break
        case .a45:
            angleValue = 45
            break
        case .a90:
            angleValue = 90
            break
        case .a135:
            angleValue = 135 - 90
            break
        case .Custom(let value):
            angleValue = CGFloat(value)
            if angleValue > 180 {
                print("angleValue for XAxis can't be more than 180 or less than 0. angleValue WILL be set to 180 degress")
                angleValue = 180
            } else if angleValue < 0 {
                print("angleValue for XAxis can't be more than 180 or less than 0. angleValue WILL be set to 180 degress")
                angleValue = 0
            } else {
                if angleValue > 90 {
                    angleValue = angleValue - 90
                }
            }
            
            break
        }
        
        return CGFloat(cos(degrees:Double((90.0 - angleValue))))*majorSizeOfLabels
        
    }
    
    internal func changeFormatterInXAxis(config:XLabelFormatter,xAxis:XAxis) {
        switch config {
        case .String:
            xAxis.valueFormatter = StringFormatter(xLabel: xLabel)
        case .Date(let stringFormatter):
            let formatter = DateFormatter()
            if let form = stringFormatter {
                formatter.dateFormat = form
            } else {
                formatter.dateFormat = "MMM dd ha"
            }
            
            var values = [Double]()
            for value in xLabel  {
                if let valueDouble = Double(value) {
                    values.append(valueDouble)
                } else {
                    print("Wrong value in array to transform in date foramatter, 0 will replace")
                    values.append(0)
                }
            }
            xAxis.valueFormatter = TimeStampFormatter(xLabel: values, formatter: formatter)
        }
    }
    
    internal func cos(degrees: Double) -> Double {
        return __cospi(degrees/180.0)
    }
    
}
