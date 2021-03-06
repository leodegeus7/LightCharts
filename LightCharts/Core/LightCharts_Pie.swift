//
//  LightCharts_Pie.swift
//  LightCharts
//
//  Created by Leonardo Geus on 22/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Charts

extension LightCharts {
    func plotPieChart(config:PieChartConfig) {
        let pie = PieChartView()
        pie.frame = view.frame
        view.addSubview(pie)
        chartView = pie
        
        pie.chartDescription?.enabled = false
        pie.backgroundColor = UIColor.white
        pie.translatesAutoresizingMaskIntoConstraints = false
        pie.noDataTextColor = UIColor.white
        pie.noDataText = "No data for the chart"
        pie.rotationAngle = 270
        legend = pie.legend
        pie.backgroundColor = config.backGroundColor
        let chartData = PieChartData()
        
        let serie = series.first!
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0...serie.entries.count-1 {
            let label = xLabel[i]
            let value = serie.entries[i]
            let entry = PieChartDataEntry(value: value, label: label)
            
            dataEntries.append(entry)
        }
        let pieDataSet = PieChartDataSet(values: dataEntries, label: serie.label)
        pieDataSet.sliceSpace = 2
        

        
        pieDataSet.colors = serie.colors
        chartData.addDataSet(pieDataSet)
        
        if let d = config.drawValues {
            switch d {
            case .True(let font, let color,let formatter, let exteriorize):
                if let formatter = formatter {
                    switch formatter {
                    case .String:
                        break
                    case .Percent:
                        pie.usePercentValuesEnabled = true
                        let pFormatter = NumberFormatter()
                        pFormatter.numberStyle = .percent
                        pFormatter.maximumFractionDigits = 1
                        pFormatter.multiplier = 1
                        pFormatter.percentSymbol = " %"
                        chartData.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
                        break
                    }
                }
                if let f = font {
                    changeEntriesFont(size: f, dataSet: chartData)
                }
                if let c = color {
                    
                    chartData.setValueTextColor(c)
                }
                if let _ = exteriorize {
                    if exteriorize == true {
                        pieDataSet.valueLinePart1OffsetPercentage = 0.8
                        pieDataSet.valueLinePart1Length = 0.4
                        pieDataSet.valueLinePart2Length = 0.4
                        pieDataSet.yValuePosition = .outsideSlice
                        
                    } else {
                        pieDataSet.yValuePosition = .insideSlice
                    }

                } else {
                    pieDataSet.yValuePosition = .insideSlice
                }
                chartData.setDrawValues(true)
                break
            case .False:
                chartData.setDrawValues(false)
                break
            }
        }
        
        if let d = config.drawXAxis {
            switch d{
            case .True(let font, let color, let exteriorize):

                if let c = color {
                    pieDataSet.entryLabelColor = c
                }
                if let font = font {
                    switch font {
                    case .Small:
                        pieDataSet.entryLabelFont = UIFont.systemFont(ofSize: 8)
                    case .Medium:
                        pieDataSet.entryLabelFont = UIFont.systemFont(ofSize: 10)
                    case .Large:
                        pieDataSet.entryLabelFont = UIFont.systemFont(ofSize: 12)
                    case .Custom(let font2):
                        pieDataSet.entryLabelFont = font2
                    }
                }
                if let _ = exteriorize {
                    pieDataSet.valueLinePart1OffsetPercentage = 0.8
                    pieDataSet.valueLinePart1Length = 0.4
                    pieDataSet.valueLinePart2Length = 0.4
                    pieDataSet.xValuePosition = .outsideSlice
                } else {
                    pieDataSet.xValuePosition = .insideSlice
                }
                break
            case .False:
                pieDataSet.entryLabelColor = UIColor.clear
                break
            }
        }
        pie.highlightValue(Highlight())
        pie.drawHoleEnabled = !config.drawHole
        
        pie.centerText = config.centerText
        pie.drawCenterTextEnabled = true
        
        //Create DataSet
        pie.data = chartData
        
    }
    
    
    public func spinGraph(seconds:Float,indexToSpin:Int) {
        if type == .Pie {
            let pie = chartView as! PieChartView
            
            var centerAngles:[Float] = []
            var initialAngle:CGFloat = 0
            for angle in pie.absoluteAngles {
                let centerAngle = (angle - initialAngle)/2 + initialAngle
                centerAngles.append(Float(centerAngle))
                initialAngle = angle
            }
            if indexToSpin < centerAngles.count || indexToSpin == 0 {
                let itemAngle = 270.0 - centerAngles[indexToSpin]
                let rotationAngle = pie.rotationAngle
                pie.spin(duration: TimeInterval(seconds), fromAngle: rotationAngle, toAngle: CGFloat(itemAngle))
            } else {
                print("Item to go in spin don't exist")
            }
            
        } else if type == .Radar {
            let pie = chartView as! RadarChartView
            
            var centerAngles:[Float] = []
            var initialAngle:CGFloat = 0
            
            var angles = [CGFloat]()
            
            for index in 1...xLabel.count {
                let restAngle = (360.0)/CGFloat(xLabel.count)
                angles.append(restAngle*CGFloat(index))
            }
            
            for angle in angles {
                
                let centerAngle = (angle - initialAngle)/2 + initialAngle
                centerAngles.append(Float(centerAngle))
                initialAngle = angle
            }
            if indexToSpin < centerAngles.count || indexToSpin == 0 {
                let itemAngle = 270.0 - centerAngles[indexToSpin]
                let rotationAngle = pie.rotationAngle
                pie.spin(duration: TimeInterval(seconds), fromAngle: rotationAngle, toAngle: CGFloat(itemAngle))
            } else {
                print("Item to go in spin don't exist")
            }
        } else {
            print("Not possivle to spin, because this is not a pie")
        }
    }
    
    
    
}
