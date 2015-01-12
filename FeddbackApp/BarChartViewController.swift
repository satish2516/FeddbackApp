//
//  BarChartViewController.swift
//  FeddbackApp
//
//  Created by Geniusport on 12/01/15.
//  Copyright (c) 2015 fidelity. All rights reserved.
//

import UIKit

class BarChartViewController: UIViewController, JBBarChartViewDataSource,JBBarChartViewDelegate {
    var appDelegateIns:AppDelegate  = UIApplication.sharedApplication().delegate as AppDelegate
    var ratingNames = [];
    var ratingValues = [];
    
    @IBOutlet var desclabel: UILabel!
    @IBOutlet var barView: JBBarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
     //setting bar view attributes
        barView.backgroundColor = UIColor.darkGrayColor()
        barView.dataSource = self
        barView.delegate = self
        barView.minimumValue  = 0
        barView.maximumValue = 100
        //settinh animation for barView
        barView.setState(JBChartViewState.Collapsed, animated: true)
        barView.reloadData()
        // Do any additional setup after loading the view.
    }
    override  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        hideChart()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ratingValues  = [appDelegateIns.totalGoodRatings! as Double,appDelegateIns.totalAvgRatings! as Double,appDelegateIns.totalBadRatings! as Double]
        ratingNames = ["good","average","bad"]
    barView.reloadData()
        barView.setState(JBChartViewState.Collapsed, animated: true)
        var timer:NSTimer  = NSTimer(timeInterval: 0.5, target: self, selector: "showChart", userInfo: nil, repeats: false)
  timer.fire()
    }
    func hideChart()
    {
        barView.setState(JBChartViewState.Collapsed, animated: true)

    }
    func showChart()
    {
         barView.setState(JBChartViewState.Expanded, animated: true)
    
    }
    
    // MARK: BarChartDelegateAndDataSource
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return UInt(ratingNames.count)
    }
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        return CGFloat(ratingValues[Int(index)] as NSNumber)
    }
    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor! {
        var barColor:UIColor?
        if index == 0
        {
            barColor = UIColor.greenColor()
        }
        else if index == 1
        {
    barColor = UIColor.yellowColor()
        }
        else if index == 2
        {
            barColor = UIColor.redColor()
        }
    return barColor
    }
    func barChartView(barChartView: JBBarChartView!, didSelectBarAtIndex index: UInt, touchPoint: CGPoint) {
        var s1:String?
        if index == 0
        {
            s1 = (appDelegateIns.ratingDict!["boothname"] as String)+" booth"+": This is rating for Good:  "
             s1=s1?.stringByAppendingFormat("%.2f %", appDelegateIns.totalGoodRatings!)
        }
        else  if index == 1
        {
            s1 = (appDelegateIns.ratingDict!["boothname"] as String)+" booth"+": This is rating for Average: "
            s1=s1?.stringByAppendingFormat("%.2f %", appDelegateIns.totalAvgRatings!)
        }
        else  if index == 2
        {
            s1 = (appDelegateIns.ratingDict!["boothname"] as String)+" booth"+": This is rating for Bad: "
            s1=s1?.stringByAppendingFormat("%.2f %", appDelegateIns.totalBadRatings!)

            
        }
        desclabel.text = s1!+"%"
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
