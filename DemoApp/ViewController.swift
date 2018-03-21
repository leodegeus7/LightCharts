//
//  ViewController.swift
//  DemoApp
//
//  Created by Leonardo Geus on 09/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit
import LightCharts
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var graph: UIView!
    
    var dataEntry: [BarChartDataEntry] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let x = ["A1","B2","C3","D4","E5","F6"]
//        let y1:[Double] = [2,3,4,5,6,7]
//        let y2:[Double] = [1,2,2,3,2,1]
//
//        let serie1 = Serie(label: "manha", entries: y1, color:UIColor.blue)
//        let serie2 = Serie(label: "tarde", entries: y2, color:UIColor.red)
//
//        let serie3 = ColorSerie(label: "manha", entries: y1, colors: [UIColor.red,UIColor.blue,UIColor.brown,UIColor.green,UIColor.lightGray,UIColor.yellow])
//
//        let light = LightCharts(graph: graph, type: .Radar, series: [serie1,serie2], xLabel: x).plot()
        
        
        
        
  //      let xStatus = ["B0OO","C000","D000","E000","F000","F100","F950","G000","G900","v900"]
//
//        let yValues:[Double] = [255,253,269,257,258,262,248,241,250,261]
//        let yValues2:[Double] = [251,223,239,247,258,262,248,241,250,261]
//
//        let config = BarChartConfig()
//        config.yRange = (nil,600)
//        config.xLabelAngle = .a90
//        config.xAxisFont = .Small
//        let serie = Serie(label: "Terca", entries: yValues, color: UIColor.red)
//
//        let light = LightCharts(graph: graph, config: config, serie: serie, xLabel: xStatus)
//
//        light.plot()
        
//        let xStatus:[String] = ["1519154110","1519067710","1518977710","1518891310","1518804910","1519154110","1519067710","1518977710","1518891310","1518804910"]
//        let yValues1:[Double] = [2,4,4,2,24]
//        //let yValues2:[Double] = [1,2,2,1,25]
//
//
//        let config = LineChartConfig()
//        config.lineWidth = .Large
//
//
//        config.drawCircles = .True(size: CircleSize.Large, fillCircle: false)
//        config.drawValues = .True(font: FontSize.Large, color: UIColor.blue)
//
//
//        let serie = Serie(label: "G900", entries: yValues, color: UIColor.blue)
//        let serie2 = Serie(label: "V900", entries: yValues2, color: UIColor.green)
//
//        config.drawXAxis = DrawAxis.True(font: FontSize.Large, labelColor: UIColor.red, drawGrid: nil)
//        config.drawYAxis = DrawAxis.True(font: FontSize.Medium, labelColor: UIColor.blue, drawGrid: nil)
//        config.xLabelAngle = .Custom(value: 140)
//
//        let config2 = BarChartConfig()
//        config2.xLabelAngle = .a0
//        config2.xLabelFormatter = .Date(stringFormatter: "yyyy")
//        config2.isStacked = .True(labelDescription:"per stack")
//        config2.drawValues = .True(font: nil, color: nil)
//
//        let light = LightCharts(graph: graph, config: config2, serie: serie, xLabel: xStatus)
//
//        //let ligt2 = LightCharts(graph: graph, config: config2, series: [serie,serie2], xLabel: xStatus)
//
//        light.plot()
        
        
        
        
        
        
        
        
        
//        let x = ["B0OO","C000","D000","E000"]
//        let y1:[Double] = [100,200,140,210]
//
//        let serie = ColorSerie(label: "Production", entries: y1, colors: [UIColor(red: 0, green: 189/255, blue: 201/255, alpha: 1),UIColor(red: 223/255, green: 72/255, blue: 99/255, alpha: 1)])
//
//        let config = BarChartConfig()
//        config.drawXAxis = .True(font: .Medium, labelColor: nil, drawGrid: false)
//        config.drawYAxis = DrawAxis.True(font: .Medium, labelColor: nil, drawGrid: false)
//

//
//
//
//        let chart = LightCharts(graph: graph, config: config, serie: serie, xLabel: x)
//
//
//        chart.plot()
//        chart.spinGraph(seconds:2,indexToSpin: 3)
        
        
        
        
        
        self.view.backgroundColor = UIColor.red
        
        let x = ["B0OO","C000","D000","E000"]
        let y1:[Double] = [100,200,140,210]
        let y2:[Double] = [150,220,120,200]
        let serie = ColorSerie(label: "Morning", entries: y1, colors: [UIColor(red: 0, green: 189/255, blue: 201/255, alpha: 1),UIColor(red: 223/255, green: 72/255, blue: 99/255, alpha: 1),UIColor(red: 0, green: 189/255, blue: 201/255, alpha: 1),UIColor(red: 223/255, green: 72/255, blue: 99/255, alpha: 1)])

        //let serie2 = Serie(label: "G100", entries: y2, color: UIColor.blue)

        let config = BarChartConfig()

        //let config = PieChartConfig()
        //let config = LineChartConfig()
        //let config = RadarChartConfig



        let chart = LightCharts(config: config, serie: serie, xLabel: x)


        chart.plot(view: graph)
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            chart.spinGraph(seconds:2,indexToSpin: 2)
            chart.highlightValueInGraph(xIndex: 2, dataSetIndex: 0)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                chart.spinGraph(seconds:2,indexToSpin: 4)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    chart.spinGraph(seconds:2,indexToSpin: 1)
                }
            }
            
        }
        
        
        

        
        sleep(3)

//        let x = ["B0OO","C000","D000","E000"]
//        let y1:[Double] = [100,200,140,210]
//        let y2:[Double] = [150,220,120,200]
//
//        let serie = ColorSerie(label: "Morning", entries: y1, colors: [UIColor(red: 0, green: 189/255, blue: 201/255, alpha: 1)])
//
//        let serie2 = ColorSerie(label: "Afternoon", entries: y2, colors: [UIColor(red: 223/255, green: 72/255, blue: 99/255, alpha: 1)])
//
////        let serie2 = ColorSerie(label: "Afternoon", entries: y2, colors: [UIColor(red: 223/255, green: 72/255, blue: 99/255, alpha: 1)])
//
//        //let serie2 = Serie(label: "G100", entries: y2, color: UIColor.blue)
//
//        let config = RadarChartConfig()
//        config.fillDataSets = FillDataSets.True(alpha: 0.8)
//        config.gridWidth = ActivateRadarGrid.True(width: nil, color: UIColor.darkGray)
//        //config.drawValues = DrawPieValues.True(font: nil, color: nil, formatter: nil, exteriorizeValue: nil)
//        //let config = PieChartConfig()
//        //let config = LineChartConfig()
//        //let config = RadarChartConfig
//
//
//
//        let chart = LightCharts(graph: graph, config: config, series: [serie,serie2], xLabel: x)
//
//
//        chart.plot()
//        chart.spinGraph(seconds:2,indexToSpin: 3)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

