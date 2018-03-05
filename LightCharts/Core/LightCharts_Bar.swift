//
//  ChartBarConfig-Bar.swift
//  LightCharts
//
//  Created by Leonardo Geus on 22/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Charts

extension LightCharts {
    
    
    func plotBarChart(config:BarChartConfig) {
        //Setup Graph
        let chart = BarChartView()
        chart.frame = view.frame
        view.addSubview(chart)
        chartView = chart
        
        chart.chartDescription?.enabled = false
        chart.dragEnabled = true
        chart.setScaleEnabled(true)
        chart.pinchZoomEnabled = false
        chart.rightAxis.enabled = false
        chart.backgroundColor = UIColor.white
        chart.translatesAutoresizingMaskIntoConstraints = false
        chart.noDataTextColor = UIColor.white
        chart.noDataText = "No data for the chart"
        chart.drawValueAboveBarEnabled = config.drawValueAboveBar
        
        let marker = BalloonMarker(color: UIColor.black, font: UIFont.systemFont(ofSize: 12), textColor: UIColor.white, insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
        chart.marker = marker
        
        legend = chart.legend
        
        if let first = config.yRange.0 {
            chart.leftAxis.axisMinimum = Double(first)
        }
        if let second = config.yRange.1 {
            chart.leftAxis.axisMaximum = Double(second)
        }
        
        let chartData = BarChartData()
        switch config.isStacked {
        case .False:
            //Create Entries
            for serie in series {
                var dataEntries: [BarChartDataEntry] = []
                for i in 0...serie.entries.count-1 {
                    let entry = BarChartDataEntry(x: Double(i), y: serie.entries[i])
                    dataEntries.append(entry)
                }
                let chartDataSet = BarChartDataSet(values: dataEntries, label: serie.label)
                chartDataSet.colors = serie.colors
                chartData.addDataSet(chartDataSet)
            }
        case .True(let labelDesc):
            var dataEntries: [BarChartDataEntry] = []
            var labels:[String] = []
            var colors:[UIColor] = []
            
            if let first = series.first {
                var i = 0
                for _ in first.entries {
                    var values = [Double]()
                    for serie in series {
                        values.append(serie.entries[i])
                    }
                    let entry = BarChartDataEntry(x: Double(i), yValues: values)
                    dataEntries.append(entry)
                    i = i + 1
                }
                for serie in series {
                    if let _ = serie.colors.first {
                        colors.append(serie.colors.first!)
                    } else {
                        print("Didn't find color for serie, Black will be set")
                        colors.append(UIColor.black)
                    }
                    labels.append(serie.label)
                }
                let chartDataSet = BarChartDataSet(values: dataEntries, label: labelDesc)
                chartDataSet.stackLabels = labels
                chartDataSet.colors = colors
                
                
                
                chartData.addDataSet(chartDataSet)
            } else {
                print("Problem to find a serie")
            }
        }
        
        switch config.drawValues {
        case .True(let font, let color):
            if let f = font {
                changeEntriesFont(size: f, dataSet: chartData)
            }
            if let c = color {
                chartData.setValueTextColor(c)
            }
            chartData.setDrawValues(true)
            break
        case .False:
            chartData.setDrawValues(false)
            break
        }
        
        //Create DataSet
        chart.data = chartData
        
        //Configure x Axis
        let xAxis = chart.xAxis
        
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        
        changeXLabelAngle(xAxis: xAxis)
        xAxis.labelCount = xLabel.count
        changeFormatterInXAxis(config: config.xLabelFormatter, xAxis: xAxis)
        chart.extraBottomOffset = calculateLabelInAxisSize(config: config)
        
        let yAxis = chart.getAxis(.left)
        changeAxisFont(axisConfig: config.drawXAxis, axis: xAxis)
        changeAxisFont(axisConfig: config.drawYAxis, axis: yAxis)
        
    }
    
    
    
}
