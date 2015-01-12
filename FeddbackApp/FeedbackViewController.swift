//
//  FeedbackViewController.swift
//  FeddbackApp
//
//  Created by Geniusport on 12/01/15.

//

import UIKit

class FeedbackViewController: UIViewController {
    
    var altObj:UIAlertController?
    
    var propAvg:Double?
    var propGood:Double?
    var propBad:Double?
    var appObj:AppDelegate=(UIApplication.sharedApplication().delegate as AppDelegate)

    @IBAction func showFeedBack(sender: UIButton) {
        //...........
        altObj = UIAlertController(title: "Authentication", message: "Please Enter Pass Code", preferredStyle: UIAlertControllerStyle.Alert)
        // to capture the alert text field text
        var mtxtField:UITextField!
        
        let okAction = UIAlertAction(title: "done", style: UIAlertActionStyle.Default, handler: {(action)->Void in
            
         if ((mtxtField! as UITextField).text == "suneel123" )
         {
            
            var barCon:BarChartViewController = BarChartViewController(nibName: "BarChartViewController", bundle: nil)
        self.presentViewController(barCon, animated: true, completion: nil)
            
        }
      
  
            
        })
        
        altObj?.addAction(okAction)
        altObj?.addTextFieldWithConfigurationHandler({ (txtField) -> Void in
            (self.altObj!.textFields![0] as UITextField).secureTextEntry=true
            
            mtxtField=txtField
            
            
        })
        self.presentViewController(altObj!, animated: true, completion: nil)

        
        
        
        //............
        
        var goodCount:Double = self.appObj.ratingDict!["good"] as Double
        var avgCount:Double = self.appObj.ratingDict!["average"] as Double

        var badCount:Double = self.appObj.ratingDict!["bad"] as Double

        var sum:Double  = goodCount + avgCount + badCount
        propAvg = (avgCount/sum)*100 as Double
        propGood = (goodCount/sum)*100 as Double
        propBad = (badCount/sum)*100 as Double
        
        appObj.totalAvgRatings = propAvg
        appObj.totalGoodRatings = propGood
        appObj.totalBadRatings = propBad
        
       
    }
    @IBAction func badRatingTapped(sender: UIButton) {
          var altObj1:UIAlertController?
       altObj1 = UIAlertController(title: (self.appObj.ratingDict!["boothname"] as String ), message: "Thanks for your valuable feedback..", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Thank Q", style: UIAlertActionStyle.Default, handler: {(action)->Void in
            var rating:Int = (self.appObj.ratingDict!["bad"] as Int)
            rating = rating + 1
            self.appObj.ratingDict!["bad"] = rating as Int
            println(self.appObj.ratingDict!)
            self.appObj.ratingDict?.writeToFile(self.appObj.getPlistPath(), atomically: true)
            
            
        })
        altObj1?.addAction(okAction)
        self.presentViewController(altObj1!, animated: true, completion: nil)

    }
      @IBOutlet var feedBackView: UIView!
  
    @IBAction func avgRatingTapped(sender: UIButton) {
        var altObj1:UIAlertController?
        altObj1 = UIAlertController(title: (self.appObj.ratingDict!["boothname"] as String ), message: "Thanks for your valuable feedback..", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Thank Q", style: UIAlertActionStyle.Default, handler: {(action)->Void in
            var rating:Int = (self.appObj.ratingDict!["average"] as Int)
            rating = rating + 1
            self.appObj.ratingDict!["average"] = rating as Int
            println(self.appObj.ratingDict!)

            self.appObj.ratingDict?.writeToFile(self.appObj.getPlistPath(), atomically: true)
            
            
        })
        altObj1?.addAction(okAction)

        self.presentViewController(altObj1!, animated: true, completion: nil)

    }
    @IBAction func goodRatingTapped(sender: UIButton) {
        println(self.appObj)
        var altObj1:UIAlertController?
         altObj1 = UIAlertController(title: (self.appObj.ratingDict!["boothname"] as String ), message: "Thanks for your valuable feedback..", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Thank Q", style: UIAlertActionStyle.Default, handler: {(action)->Void in
            var rating:Int = (self.appObj.ratingDict!["good"] as Int)
            rating = rating + 1
            self.appObj.ratingDict!["good"] = rating as Int
            println(self.appObj.ratingDict!)

            self.appObj.ratingDict?.writeToFile(self.appObj.getPlistPath(), atomically: true)
            
            
        })
        
        altObj1?.addAction(okAction)

self.presentViewController(altObj1!, animated: true, completion: nil)
    }
  override  init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
     override func viewDidAppear(animated: Bool) {
//         self.addBoothView.frame=CGRectMake(300, 284, 380, 160)
//        self.view.addSubview(addBoothView)
        if NSFileManager.defaultManager().fileExistsAtPath(self.appObj.getPlistPath())
        {
            altObj = UIAlertController(title: "Booth peristance", message: "Booth Data Exists! Do you want to override ?", preferredStyle: UIAlertControllerStyle.Alert)
  let yesAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default, handler: {(action)->Void in
    self.recreateBooth()
    
    })
            let noAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.Default, handler: {(action)->Void in
                
                 self.view.addSubview(self.feedBackView!)
                self.appObj.ratingDict=NSMutableDictionary(contentsOfFile: self.appObj.getPlistPath())
                
            })
            
        altObj?.addAction(yesAction)
        altObj?.addAction(noAction)
            self.presentViewController(altObj!, animated: true, completion: nil)
            
           

            
        }else
        {
            recreateBooth()
        }
        
    }
    
     func recreateBooth()
     {
        altObj = UIAlertController(title: "Booth Name", message: "Please Enter Booth Name", preferredStyle: UIAlertControllerStyle.Alert)
        // to capture the alert text field text
        var mtxtField:UITextField!
        
        let okAction = UIAlertAction(title: "done", style: UIAlertActionStyle.Default, handler: {(action)->Void in
            //creating app delegate class instance
            //            self.appObj = (UIApplication.sharedApplication().delegate as AppDelegate)
            self.appObj.ratingDict  = NSMutableDictionary()
            self.appObj.ratingDict!["boothname"] = (mtxtField.text as String)
            self.appObj.ratingDict!["good"] = 0 as Int
            self.appObj.ratingDict!["average"] = 0 as Int
            self.appObj.ratingDict!["bad"] = 0 as Int
            self.appObj.ratingDict?.writeToFile(self.appObj.getPlistPath(), atomically: true)
            self.feedBackView.frame=self.view.frame
            self.view.addSubview(self.feedBackView!)
            
        })
        
        altObj?.addAction(okAction)
        altObj?.addTextFieldWithConfigurationHandler({ (txtField) -> Void in
            
            
            mtxtField=txtField
            
            
        })
        self.presentViewController(altObj!, animated: true, completion: nil)
        

    }
    func configurationTextField(textField:UITextField)
    {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
