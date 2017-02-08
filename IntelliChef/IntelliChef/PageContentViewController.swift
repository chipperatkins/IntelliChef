//
//  PageContentViewController.swift
//  IntelliChef
//
//  Created by Patrick Atkins on 2/4/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController, PageViewControllerDelegate {

 
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    var pageIndex: Int = 0

    var strTitle: String!
    var strPhotoName: String!
    var seconds: Int = 3600 //seconds
    
    
    var delegator: PageViewController?
    var timer = Timer()
    
    
    @IBAction func swipeLeft(_ sender: Any) {
        delegator?.actionLeft(pageContentViewController: self)
        //check step, if has timer set hasTimer = true
    }
    @IBAction func swipeRight(_ sender: Any) {
        delegator?.actionRight(pageContentViewController: self)
    }
    
    @IBAction func start(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PageContentViewController.counter), userInfo: nil, repeats: true)
    }
    
    func counter(){
        seconds -= 1
        timerLabel.text = self.toString(seconds)
        
        if (seconds == 0){
            timer.invalidate()
        }
    }
    
    func toString(_ seconds: Int) -> String{
        var r = ""
        var min = Int(seconds/60)
        let sec = Int(seconds % 60)
        var hour = 0
        if (min >= 60){
            hour = min/60
            min = min % 60
        }
        
        if (hour == 0) {r += String(min) + ":" + String(sec)}
        else {r += String(format: "%02d", hour) + ":" + String(format: "%02d",min) + ":" + String(format: "%02d",sec)}
        
        return r
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = strTitle
        timerLabel.text = self.toString(seconds)
        //image.image = UIImage(named: strPhotoName)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didFinishTask(sender: PageViewController) {} //for protocol delegator

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
