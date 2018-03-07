


![](https://i.imgur.com/xTzErOi.jpg)

> Create easy and beautiful graphs using all power of Charts Framework in a few seconds


## Installation

POD Installation:

```sh
pod 'LightCharts', :git => 'https://github.com/leodegeus7/LightCharts.git'
```

![](https://i.imgur.com/uyRmVxF.jpg)

## Usage example

To use this tool you need to follow few steps:

1) Create a UIView in your Storyboard
2) Link an outlet of this view in your Controller and import the framework LightCharts;
3) Create your series to plot in graph, graphs may have more than one serie, so feel free to create as many serie as you want

```sh
let x = ["B0OO","C000","D000","E000"]
let y1:[Double] = [100,200,300,400]
let serie1 = Serie(label: "Monday", entries: y1, color: UIColor.red)
let y2:[Double] = [130,180,310,420]
let serie2 = Serie(label: "Tuesday", entries: y2, color: UIColor.yellow)
```
4) Instantiate a chart config, this config need to be consistent with your graph type. ChartConfig is the way that you can customize and choose the the type of your chart. There are four types of graph in this tool: Bar, Pie, Line, Radar.

```sh
let config = BarChartConfig()
let config = PieChartConfig()
let config = LineChartConfig()
let config = RadarChartConfig()
```

5) To finish, create a new object of the type LightsCharts passing the view created in Item 1, the config created in item 4, the serie created in item 3 and an array of strings to label your series. 

```sh
let chart = LightCharts(graph: graph, config: config, serie: serie, xLabel: x)
chart.plot()
```

**EXTRAS**
6) Customization. For example, to draw the values in the middle of the bar and change the size of label in X Axis just edit the config file:
Hint: pass *nil* on properties you dont want to change, this tool will get the best parameters to you.

```sh
let config = BarChartConfig()
config.drawValues = .True(font: .Medium, color: UIColor.red)
config.drawXAxis = .True(font: .Medium, labelColor: nil, drawGrid: nil)
```

7) Animations. To animate your graph in real time, use the functions .highlightValueInGraph() and spinGraph() in LightCharts object.

```sh
chart.spinGraph(seconds:2,indexToSpin: 3)
chart.highlightValueInGraph(xIndex: 3, dataSetIndex: 0)
```


![Alt Text](https://media.giphy.com/media/3mgxJ9dfVNR32prrGV/giphy.gif)


## Release History

* 0.0.1
    * First Commit
* 0.0.2
    * Added Animations

## References

Charts: [https://github.com/danielgindi/Charts](https://github.com/danielgindi/Charts)

## Meta

Leonardo Alexandre de Geus – [@leodegeus7](https://www.linkedin.com/in/leodegeus7/) – leonardodegeus@gmail.com

See ``LICENSE`` for more information.

[https://github.com/leodegeus7](https://github.com/leodegeus7)


