//
//  PageContentViewController.swift
//  IntelliChef
//
//  Created by Patrick Atkins on 2/4/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController, PageViewControllerDelegate {

 
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    public var delegateTimerLabel: Float!
    var pageIndex: Int = 0
    //var timerManager = TimerManager()
    var strTitle: String!
    var strPhotoName: String!
    var time: Int = 0
    
    
    var delegator: PageViewController?
    
    
    @IBAction func swipeLeft(_ sender: Any) {
        delegator?.actionLeft(pageContentViewController: self)
        //check step, if has timer set hasTimer = true
    }
    @IBAction func swipeRight(_ sender: Any) {
        delegator?.actionRight(pageContentViewController: self)
    }
    //@IBAction func buttonPress(_ sender: UIButton) { Button implementation for right
    //    delegator?.actionRight(pageContentViewController: self)
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //timerManager.sharedInstance.start(time: 100)
        timerLabel.text = "Timer: 00:00"
        //check if hasTimer
        //instastiate it and call decreaseTimer, set hasTimer to false, time should continue on each screen
        label.text = strTitle
        //image.image = UIImage(named: strPhotoName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didFinishTask(sender: PageViewController) {
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
