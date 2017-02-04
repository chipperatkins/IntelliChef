//
//  PageViewController.swift
//  IntelliChef
//
//  Created by Patrick Atkins on 2/4/17.
//  Copyright © 2017 Joey Murphy. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource
{
    
    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    
    var nextViewController: PageContentViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrPageTitle = ["This is The App Guruz", "This is Table Tennis 3D", "This is Hide Secrets"];
        arrPagePhoto = ["1.jpg", "2.jpg", "3.jpg"];
        self.setViewControllers([getViewControllerAtIndex(0   )] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }
    func action() {
        
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
        
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "PageContentViewController") as! PageContentViewController
        
        let resultView = pageViewController(ViewController, viewControllerAfter: pageContentViewController)
        
        self.setViewControllers([resultView!] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        }

    // MARK:- UIPageViewControllerDataSource Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        
        var index = pageContent.pageIndex
        
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        
        index -= 1;
        return getViewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PageContentViewController = viewController as! PageContentViewController
        
        var index = pageContent.pageIndex
        
        if (index == NSNotFound)
        {
            return nil;
        }
        
        index += 1;
        if (index == arrPageTitle.count)
        {
            return nil;
        }
        return getViewControllerAtIndex(index)
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
