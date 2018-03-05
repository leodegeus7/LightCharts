//
//  LightCharts_Radar.swift
//  LightCharts
//
//  Created by Leonardo Geus on 22/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import Charts

extension LightCharts {
    func plotRadarChart(config:RadarChartConfig) {
        let radar = RadarChartView()
        radar.frame = view.frame
        view.addSubview(radar)
        chartView = radar
        
        radar.chartDescription?.enabled = false
        radar.backgroundColor = UIColor.white
        radar.translatesAutoresizingMaskIntoConstraints = false
        radar.noDataTextColor = UIColor.white
        radar.noDataText = "No data for the chart"
        
        radar.webAlpha = 1
        
        let marker = BalloonMarker(color: UIColor.black, font: UIFont.systemFont(ofSize: 12), textColor: UIColor.white, insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0))
        radar.marker = marker
        
        switch config.gridWidth {
        case .True(let width, let color):
            if let w = width {
                radar.webLineWidth = w
                radar.innerWebLineWidth = w
            }
            if let c = color {
                radar.webColor = c
                radar.innerWebColor = c
            }
        case .False:
            radar.webLineWidth = 0
            radar.innerWebLineWidth = 0
            radar.webColor = UIColor.clear
            radar.innerWebColor = UIColor.clear
        }

        
        legend = radar.legend
        
        
        let chartData = RadarChartData()
        for serie in series {
            var dataEntry: [RadarChartDataEntry] = []
            for i in 0...serie.entries.count-1 {
                let entry = RadarChartDataEntry(value: serie.entries[i])
                dataEntry.append(entry)
            }
            
            let radarDataSet = RadarChartDataSet(values: dataEntry, label: serie.label)
            
            switch config.fillDataSets {
            case .False:
                radarDataSet.drawFilledEnabled = false
            case .True(let alpha):
                if let first = serie.colors.first {
                    radarDataSet.fillColor = first
                    if let a = alpha {
                        radarDataSet.fillAlpha = CGFloat(a)
                    }
                    radarDataSet.drawFilledEnabled = true
                }
            }
            if let w = config.widthDataSets {
                radarDataSet.lineWidth = w
            }
            radarDataSet.colors = serie.colors
            chartData.addDataSet(radarDataSet)
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
        radar.data = chartData
        
        
        let xAxis = radar.xAxis
        
        xAxis.granularity = 1
        changeXLabelAngle(xAxis: xAxis)
        changeFormatterInXAxis(config: config.xLabelFormatter, xAxis: xAxis)
        let yAxis = radar.yAxis
        
        changeRadarAxisFont(axisConfig: config.drawXAxis, axis: xAxis)
        changeRadarAxisFont(axisConfig: config.drawYAxis, axis: yAxis)
        
        
        
    }
}
