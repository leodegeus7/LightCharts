//
//  LightCharts_Line.swift
//  LightCharts
//
//  Created by Leonardo Geus on 22/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Charts

extension LightCharts {
    func plotLineChart(config:LineChartConfig) {
        let line = LineChartView()
        line.frame = view.frame
        view.addSubview(line)
        chartView = line
        
        line.chartDescription?.enabled = false
        line.dragEnabled = true
        line.setScaleEnabled(true)
        line.pinchZoomEnabled = false
        line.rightAxis.enabled = false
        line.backgroundColor = UIColor.white
        line.translatesAutoresizingMaskIntoConstraints = false
        line.animate(xAxisDuration: 2, yAxisDuration: 2, easingOption: .easeInBounce)
        line.noDataTextColor = UIColor.white
        line.noDataText = "No data for the chart"
        
        legend = line.legend
        
        
        if let first = config.yRange.0 {
            line.leftAxis.axisMinimum = Double(first)
        }
        if let second = config.yRange.1 {
            line.leftAxis.axisMaximum = Double(second)
        }
        
        
        let chartData = LineChartData()
        let formatter = IntegerFormatter()
        chartData.setValueFormatter(formatter)
        
        for serie in series {
            var dataEntries: [ChartDataEntry] = []
            for i in 0...serie.entries.count-1 {
                let entry = ChartDataEntry(x: Double(i), y: serie.entries[i])
                dataEntries.append(entry)
            }
            let chartDataSet = LineChartDataSet(values: dataEntries, label: serie.label)
            
            
            chartDataSet.colors = serie.colors
            chartDataSet.mode = .linear

            guard let color = serie.colors.first else {
                print("problem to find first color in array")
                return
            }
            
            drawCircles(config: config.drawCircles, dataset: chartDataSet, colorFill: color)
            chartDataSet.circleColors = serie.colors
            
            if let li = config.lineWidth {
                switch li {
                case .Small:
                    chartDataSet.lineWidth = 1
                case .Medium:
                    chartDataSet.lineWidth = 3
                case .Large:
                    chartDataSet.lineWidth = 6
                case .SuperLarge:
                    chartDataSet.lineWidth = 9
                case .Custom(let int):
                    chartDataSet.lineWidth = CGFloat(int)
                }
            }
            chartData.addDataSet(chartDataSet)
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
        line.data = chartData
        
        //Configure x Axis
        let xAxis = line.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        changeXLabelAngle(xAxis: xAxis)
        
        changeFormatterInXAxis(config: config.xLabelFormatter, xAxis: xAxis)
        
        line.extraBottomOffset = calculateLabelInAxisSize(config: config)
        
        let yAxis = line.getAxis(.left)
        
        
        changeAxisFont(axisConfig: config.drawXAxis, axis: xAxis)
        changeAxisFont(axisConfig: config.drawYAxis, axis: yAxis)
        
    }

    
    
    private func drawCircles(config:DrawCircles?,dataset:LineChartDataSet,colorFill:UIColor) {
        if let c = config {
            switch c {
            case .True(let size, let fill):
                if let s = size {
                    switch s {
                    case .Small:
                        dataset.circleRadius = 5
                    case .Medium:
                        dataset.circleRadius = 8
                    case .Large:
                        dataset.circleRadius = 13
                    case .Custom(let int):
                        dataset.circleRadius = CGFloat(int)
                    }
                }
                if let f = fill {
                    if f {
                        dataset.circleHoleColor = colorFill
                    } else {
                        dataset.circleHoleColor = UIColor.white
                    }
                }
                dataset.drawCirclesEnabled = true
                break
            case .False:
                dataset.drawCirclesEnabled = false
                break
            }
        }
    }
}
