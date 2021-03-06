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
    
    var nextViewController: PageContentViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrPageTitle = ["This is The App Guruz", "This is Table Tennis 3D", "This is Hide Secrets"];
        arrPagePhoto = ["1.jpg", "2.jpg", "3.jpg"];
        
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

        return pageContentViewController
    }
}

protocol PageViewControllerDelegate: class {
    func didFinishTask(sender: PageViewController)
}

