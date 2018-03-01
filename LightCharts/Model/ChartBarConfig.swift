//
//  ChartBarConfig.swift
//  LightCharts
//
//  Created by Leonardo Geus on 21/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

public enum XLabelAngle {
    case a0
    case a45
    case a90
    case a135
    case Custom(value:Double)
}

public enum FontSize {
    case Medium
    case Large
    case Small
    case Custom(font:UIFont)
}

public enum LineSize {
    case Small
    case Medium
    case Large
    case SuperLarge
    case Custom(size:Int)
}

public enum CircleSize {
    case Medium
    case Large
    case Small
    case Custom(size:Int)
}

public enum DateFormatterSyle {
    case Medium
    case Large
    case Small
    case Custom(font:UIFont)
}

public enum XLabelFormatter {
    case String
    case Date(stringFormatter:String?)
}

public enum ValuePieFormatter {
    case String
    case Percent
}

public enum AxisPieFormatter {
    case String
    case Percent
    case Date(stringFormatter:String?)
}

public enum IsStacked {
    case False
    case True(labelDescription:String?)
}

public enum DrawValues {
    case True(font:FontSize?,color:UIColor?)
    case False
}


public enum DrawCircles {
    case True(size:CircleSize?,fillCircle:Bool? )
    case False
}

public enum DrawAxis {
    case True(font:FontSize?,labelColor:UIColor?,drawGrid:Bool?)
    case False
}

public enum DrawRadarAxis {
    case True(font:FontSize?,labelColor:UIColor?)
    case False
}

public enum ActivateRadarGrid {
    case True(width:CGFloat?,color:UIColor?)
    case False
}

public enum FillDataSets {
    case True(alpha:Float?)
    case False
}

public enum DrawPieAxis {
    case True(font:FontSize?,labelColor:UIColor?,exteriorizeValue:Bool?)
    case False
}

public enum DrawPieValues {
    case True(font:FontSize?,color:UIColor?,formatter:ValuePieFormatter?,exteriorizeValue:Bool?)
    case False
}

public protocol ChartConfigProtocol {


}

public protocol OneDimensionGraphProtocol: ChartConfigProtocol {

}

public protocol TwoDimensionGraphProtocol: ChartConfigProtocol {
    var drawValues:DrawValues {get set}
    var yRange:(Int?,Int?) {get set}
    var xLabelAngle:XLabelAngle {get set}
    var xLabelFormatter:XLabelFormatter {get set}

}

public protocol SimpleGraphProtocol:ChartConfigProtocol {
    var drawXAxis : DrawAxis? {get set}
    var drawYAxis : DrawAxis? {get set}
}

public class BarChartConfig: TwoDimensionGraphProtocol,SimpleGraphProtocol {
    public var xLabelFormatter: XLabelFormatter = .String
    public var drawXAxis: DrawAxis? = .True(font: FontSize.Medium, labelColor: UIColor.black, drawGrid: true)
    public var drawYAxis: DrawAxis? = .True(font: FontSize.Medium, labelColor: UIColor.black, drawGrid: true)
    public var drawValues:DrawValues = .False
    public var xLabelAngle: XLabelAngle = .a0
    public var yRange: (Int?, Int?) = (nil,nil)
    public var drawValueAboveBar = false
    public var isStacked:IsStacked = .False
    
    
    public init() {
        
    }
}

public class LineChartConfig: TwoDimensionGraphProtocol,SimpleGraphProtocol {
    public var xLabelFormatter: XLabelFormatter = .String
    public var drawXAxis: DrawAxis? = .True(font: FontSize.Medium, labelColor: UIColor.black, drawGrid: true)
    public var drawYAxis: DrawAxis? = .True(font: FontSize.Medium, labelColor: UIColor.black, drawGrid: true)
    public var xLabelAngle: XLabelAngle = .a0
    public var yRange: (Int?, Int?) = (nil,nil)
    public var lineWidth: LineSize? = nil
    public var drawCircles:DrawCircles = .False
    public var drawValues:DrawValues = .False
    
    public init() {
        
    }
}

public class RadarChartConfig:TwoDimensionGraphProtocol {
    public var yRange: (Int?, Int?) = (nil,nil)
    public var xLabelAngle: XLabelAngle = .a0
    public var xLabelFormatter: XLabelFormatter = .String
    public var drawXAxis: DrawRadarAxis? = .True(font: FontSize.Medium, labelColor: UIColor.black)
    public var drawYAxis: DrawRadarAxis? = .True(font: FontSize.Medium, labelColor: UIColor.black)
    public var drawValues:DrawValues = .False
    public var gridWidth:ActivateRadarGrid = .True(width: 1, color: UIColor.gray)
    public var fillDataSets: FillDataSets = .False
    public var widthDataSets: CGFloat? = nil
    
    public init() {
        
    }
    
}


public class PieChartConfig:OneDimensionGraphProtocol {
    
    public var drawValues:DrawPieValues? = .False
    public var drawXAxis:DrawPieAxis? = .False
    public var drawHole:Bool = false
    public var centerText:String = ""
    
    public init() {
        
    }
}


