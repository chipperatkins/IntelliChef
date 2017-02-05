//
//  PageViewController.swift
//  IntelliChef
//
//  Created by Patrick Atkins on 2/4/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController
{
    
    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    var arrTimer: [Float] = []
    var nextViewController: PageContentViewController?
    var timerManager = TimerManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerManager.sharedInstance.start(time: 100)
        arrPageTitle = ["Step 1: Gather Ingredients", "Step 2: Follow the nicely written, interactive steps", "Step 3: Enjoy your meal!", "Step 4: Tell your friends about Intellichef"];
        arrPagePhoto = ["1.jpg", "2.jpg", "3.jpg", "4.jpg"];
        arrTimer = [100.0, 100.0, 100.0, 100.0]
        
        nextViewController = getViewControllerAtIndex(0)
        nextViewController?.delegator = self
        
        self.setViewControllers([nextViewController!] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    func actionRight(pageContentViewController: PageContentViewController) {
        
        nextViewController = pageViewController((nextViewController?.delegator!)!, viewControllerAfter: pageContentViewController)
        
        nextViewController?.delegator = self
        
        self.setViewControllers([nextViewController!] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    func actionLeft(pageContentViewController: PageContentViewController) {
        
        nextViewController = pageViewController((nextViewController?.delegator!)!, viewControllerBefore: pageContentViewController)
        
        nextViewController?.delegator = self
        
        self.setViewControllers([nextViewController!] as [UIViewController], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
    }
    
    // MARK:- UIPageViewControllerDataSource Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> PageContentViewController
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        
        var index = pageContent.pageIndex
        
        if ((index > 0) || (index == NSNotFound))
        {
            index -= 1;
            return getViewControllerAtIndex(index)
        }
        else {return getViewControllerAtIndex(0)}
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> PageContentViewController
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        
        var index = pageContent.pageIndex
        
        
        if (index+1 < arrPageTitle.count && index != NSNotFound)
        {
            index += 1;
            return getViewControllerAtIndex(index)
        }
        else {return getViewControllerAtIndex(0)}
    }
    
    // MARK:- Other Methods
    func getViewControllerAtIndex(_ index: NSInteger) -> PageContentViewController
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        pageContentViewController.strTitle = "\(arrPageTitle[index])"
        pageContentViewController.strPhotoName = "\(arrPagePhoto[index])"
        pageContentViewController.pageIndex = index
        //let checkTime = arrTimer[index]
        pageContentViewController.time = Int(timerManager.time)
        //var count = 0
        print(index)
        //if checkTime > 0 && count == 0{
        //    timer.time = Int(arrTimer[index])
        //}
        //timerManager.start(time: 100)
        //count += 1
        
        return pageContentViewController
    }
}

protocol PageViewControllerDelegate: class {
    func didFinishTask(sender: PageViewController)
}

