//
//  AlarmDetailViewController.swift
//  SonosSnooze
//
//  Created by Eric Chen on 10/10/17.
//  Copyright © 2017 Eric Chen. All rights reserved.
//

import UIKit
import ScrollableGraphView

class AlarmDetailViewController: UIViewController, ScrollableGraphViewDataSource {
    
    @IBAction func closePressed(_ sender: Any) {
        print("Close Pressed")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // Taken from ScrollableGraphView Example code
    //
    //  Simple example usage of ScrollableGraphView.swift
    //  #################################################
    //
    
    var graphView: ScrollableGraphView!
    var currentGraphType = GraphType.multiOne
    var graphConstraints = [NSLayoutConstraint]()
    
    var label = UILabel()
    var reloadLabel = UILabel()
    
    // Data for the different plots
    
    var numberOfDataItems = 16

    lazy var darkLinePlotData: [Double] = self.generateRandomData(self.numberOfDataItems, max: 80, shouldIncludeOutliers: true)
    
    // Labels for the x-axis
    
    lazy var xAxisLabels: [String] =  self.generateSequentialLabels(self.numberOfDataItems, text: "FEB")
    
    // Init
    // ####
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        graphView = createDarkGraph(self.view.frame)
  
        self.view.insertSubview(graphView, at: 0)
    }
    
    // Implementation for ScrollableGraphViewDataSource protocol
    // #########################################################
    
    // You would usually only have a couple of cases here, one for each
    // plot you want to display on the graph. However as this is showing
    // off many graphs with different plots, we are using one big switch
    // statement.
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        
        switch(plot.identifier) {
        case "darkLine":
            return darkLinePlotData[pointIndex]
        case "darkLineDot":
            return darkLinePlotData[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        // Ensure that you have a label to return for the index
        return xAxisLabels[pointIndex]
    }
    
    func numberOfPoints() -> Int {
        return numberOfDataItems
    }
    
    // Reference lines are positioned absolutely. will appear at specified values on y axis
    fileprivate func createDarkGraph(_ frame: CGRect) -> ScrollableGraphView {
        let rect = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: 400)
        let graphView = ScrollableGraphView(frame: rect, dataSource: self)
        
        // Setup the line plot.
        let linePlot = LinePlot(identifier: "darkLine")
        
        linePlot.lineWidth = 1
        linePlot.lineColor = UIColor.colorFromHex(hexString: "#777777")
        linePlot.lineStyle = ScrollableGraphViewLineStyle.smooth
        
        linePlot.shouldFill = true
        linePlot.fillType = ScrollableGraphViewFillType.gradient
        linePlot.fillGradientType = ScrollableGraphViewGradientType.linear
        linePlot.fillGradientStartColor = UIColor.colorFromHex(hexString: "#555555")
        linePlot.fillGradientEndColor = UIColor.colorFromHex(hexString: "#444444")
        
        linePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        let dotPlot = DotPlot(identifier: "darkLineDot") // Add dots as well.
        dotPlot.dataPointSize = 2
        dotPlot.dataPointFillColor = UIColor.white
        
        dotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the reference lines.
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white
        
        referenceLines.positionType = .absolute
        // Reference lines will be shown at these values on the y-axis.
        referenceLines.absolutePositions = [10, 50, 75, 100]
        referenceLines.includeMinMax = false
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        // Setup the graph
        graphView.backgroundFillColor = UIColor.colorFromHex(hexString: "#333333")
        graphView.dataPointSpacing = 40
        
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = false
        graphView.shouldRangeAlwaysStartAtZero = true
        
        graphView.rangeMax = 130
        
        // Add everything to the graph.
        graphView.addReferenceLines(referenceLines: referenceLines)
        graphView.addPlot(plot: linePlot)
        graphView.addPlot(plot: dotPlot)
        
        return graphView
    }
    
    // Data Generation
    private func generateRandomData(_ numberOfItems: Int, max: Double, shouldIncludeOutliers: Bool = true) -> [Double] {
        var data = [Double]()
        for _ in 0 ..< numberOfItems {
            var randomNumber = Double(arc4random()).truncatingRemainder(dividingBy: max)
            
            if(shouldIncludeOutliers) {
                if(arc4random() % 100 < 10) {
                    randomNumber *= 3
                }
            }
            
            data.append(randomNumber)
        }
        return data
    }
    
    private func generateRandomData(_ numberOfItems: Int, variance: Double, from: Double) -> [Double] {
        
        var data = [Double]()
        for _ in 0 ..< numberOfItems {
            
            let randomVariance = Double(arc4random()).truncatingRemainder(dividingBy: variance)
            var randomNumber = from
            
            if(arc4random() % 100 < 50) {
                randomNumber += randomVariance
            }
            else {
                randomNumber -= randomVariance
            }
            
            data.append(randomNumber)
        }
        return data
    }
    
    private func generateSequentialLabels(_ numberOfItems: Int, text: String) -> [String] {
        var labels = [String]()
        for i in 0 ..< numberOfItems {
            let hoursPassed = i/2
            let halfHour = i % 2 != 0 ? "30" : "00"
            
            let time = String(hoursPassed) + ":" + halfHour
            labels.append(time)
        }
        return labels
    }
    
    // The type of the current graph we are showing.
    enum GraphType {
        case simple
        case multiOne
        case multiTwo
        case dark
        case bar
        case dot
        case pink
        
        mutating func next() {
            switch(self) {
            case .simple:
                self = GraphType.multiOne
            case .multiOne:
                self = GraphType.multiTwo
            case .multiTwo:
                self = GraphType.dark
            case .dark:
                self = GraphType.bar
            case .bar:
                self = GraphType.dot
            case .dot:
                self = GraphType.pink
            case .pink:
                self = GraphType.simple
            }
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}


