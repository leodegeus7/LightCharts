//
//  Serie.swift
//  LightCharts
//
//  Created by Leonardo Geus on 20/02/2018.
//  Copyright © 2018 Leonardo Geus. All rights reserved.
//

import UIKit

public protocol SerieProtocol {
    var label: String { get set }
    var entries: [Double] { get set }
    var colors: [UIColor] { get set }
}


public class ColorSerie: SerieProtocol {
    public var label: String
    public var entries: [Double]
    public var colors: [UIColor]
    
    public init(label:String,entries:[Double],colors:[UIColor]) {
        self.label = label
        self.entries = entries
        self.colors = colors
        if entries.count != colors.count {
            print("Y values count is different of colors count. This is going to be a problem in plot")
        }
    }
}

public class Serie: SerieProtocol {
    public var label: String
    public var entries: [Double]
    public var colors: [UIColor]
    
    public init(label:String,entries:[Double],color:UIColor) {
        self.label = label
        self.entries = entries
        self.colors = []
        self.colors.append(color)
    }
}



