//
//  MCHistoryViewController.swift
//  MotiveCard
//
//  Created by Ahmad on 7/6/16.
//  Copyright © 2016 Ahmad. All rights reserved.
//

import UIKit
import Charts

class MCHistoryViewController: UIViewController {
    
    var dataSource = [MCHistory]()
    var dateFormatter = NSDateFormatter()
    
    @IBOutlet weak var chartView: LineChartView!
    
    override func viewDidLoad() {
        
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dataSource = MCHandlers.getLocalHistory()
        
        self.configureChart()
        
        super.viewDidLoad()

    }

}

extension MCHistoryViewController {
    
    func configureChart() {
        
        self.configureData()
        
        self.chartView.delegate = self
        
        self.chartView.xa
        
    }
    
    func configureData() {
        
        let xVals = ["1","2","3"]
        
        let one = ChartDataEntry(value: 1, xIndex: 0)
        let two = ChartDataEntry(value: 2, xIndex: 1)
        let three = ChartDataEntry(value: 1, xIndex: 2)
        
        let newSet = LineChartDataSet(yVals: [one,two,three], label: "Data Set 1")
        
        newSet.mode = .CubicBezier
        newSet.drawCirclesEnabled = false
        
//        let gradientColors = [
//            ChartColorTemplates.colorFromString("00ff0000").CGColor,
//            ChartColorTemplates.colorFromString("ffff0000").CGColor
//            ]
//        let gradient = CGGradientCreateWithColors(nil, gradientColors, nil);
//        //newSet.fillAlpha = 1;
//        newSet.fill = ChartFill.fillWithLinearGradient(gradient!, angle: 90)
//        newSet.drawFilledEnabled = true
        
        
        let chartData = LineChartData(xVals: xVals, dataSets: [newSet])
        
        self.chartView.data = chartData;
        self.chartView.animate(xAxisDuration: 0.25, easingOption: .EaseInOutQuart)
        
    }
    
}

extension MCHistoryViewController: ChartViewDelegate {
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        
        print(entry)
        
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        
        
        
    }
    
}

//extension MCHistoryViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return dataSource.count
//        
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let thisHistory = dataSource[indexPath.row]
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
//        
//        cell?.textLabel?.text = dateFormatter.stringFromDate(thisHistory.reviewDate)
//        
//        return cell!
//        
//    }
//    
//}