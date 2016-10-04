//
//  YZViewController.swift
//  PageView
//
//  Created by luckyxmobile on 16/10/4.
//  Copyright © 2016年 luckyxmobile. All rights reserved.
//

import UIKit

class YZViewController: UIViewController, UIPageViewControllerDataSource{
    
    @IBOutlet weak var restartButton: UIButton!
    var pageViewController: UIPageViewController!
    var pageTitles = Array<String>()
    var pageImages = Array<String>()
    let pageControl = UIPageControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageTitles = ["yesterday", "today", "tomorrow"]
        self.pageImages = ["img1", "img2", "img3"]
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        //self.storyboard?.instantiateViewControllerWithIdentifier("YZPageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        let startVc = self.viewControllerAtIndex(0)
        var viewControllers = [YZContentViewController]()
        viewControllers.append(startVc)
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        let screenSize = UIScreen.mainScreen().bounds
        self.pageViewController.view.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 30), size: CGSize.init(width: screenSize.width, height: screenSize.height - 200))
        self.addChildViewController(pageViewController)
        self.view.addSubview(self.pageViewController.view)
        //self.pageViewController.didMoveToParentViewController(self)
        
        setPageControl()
    }
    
    func setPageControl() {
        pageControl.numberOfPages = 3
        pageControl.center = CGPointMake(160, 360)
        self.view.addSubview(pageControl)
        pageControl.pageIndicatorTintColor = UIColor.blackColor()
        pageControl.currentPageIndicatorTintColor = UIColor.yellowColor()
        pageControl.currentPage = 0
    }
    @IBAction func restartAction(sender: AnyObject) {
        let startVc = self.viewControllerAtIndex(0) 
        var viewControllers = [YZContentViewController]()
        viewControllers.append(startVc)
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        pageControl.currentPage = 0
    }
    
    func viewControllerAtIndex(index: Int) -> YZContentViewController{
        if self.pageTitles.count == 0 || index >= self.pageTitles.count{
            return YZContentViewController()
        }
        let vc: YZContentViewController =  self.storyboard?.instantiateViewControllerWithIdentifier("YZContentViewController")as! YZContentViewController
        vc.imageFile = self.pageImages[index]
        vc.titleText = self.pageTitles[index]
        vc.pageIndex = index
      
        return vc
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        let vc = viewController as! YZContentViewController
        var index = vc.pageIndex as Int
        if index == 0 || index == NSNotFound{
            return nil
        }
        showCurrentPagePoint(index)
        index = index - 1
        return self.viewControllerAtIndex(index)
    }
    func showCurrentPagePoint(index: Int){
        pageControl.currentPage = index
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        let vc = viewController as! YZContentViewController
        var index = vc.pageIndex as Int
        if index == NSNotFound{
            return nil
        }
        showCurrentPagePoint(index)
        index = index + 1
        if index == self.pageTitles.count{
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int{
        return self.pageTitles.count
    }
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int{
        return 0
    }
}
