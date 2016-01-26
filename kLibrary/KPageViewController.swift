//
//  KPageViewController.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

protocol PageViewDelegate {
    
    func getPageItemAtIndex(index: Int) -> UIViewController
}

class KPageViewController:  UIViewController, UIPageViewControllerDataSource {
    
    var didShowPageControl = false
    
    var contentCount = 0
    
    var delegate: PageViewDelegate?
    
    func setupController(numberOfContent: Int) {
        
        contentCount = numberOfContent
        
        // 1
        let pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        
        pageController.dataSource = self
        
        // 2
        if contentCount > 0 {
            
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers(startingViewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        // 3
        addChildViewController(pageController)
        self.view.addSubview(pageController.view)
        
        // 4
        if didShowPageControl == true {
            
            setupPageControl()
        }
    }
    
    private func setupPageControl() {
        
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        if itemController.itemIndex > 0 {
            
            return getItemController(itemController.itemIndex - 1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        if itemController.itemIndex + 1 < contentCount {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    private func getItemController(itemIndex: Int) -> PageItemController? {
        
        if itemIndex < contentCount {
            
            return delegate?.getPageItemAtIndex(itemIndex) as? PageItemController
        }
        
        return nil
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        if didShowPageControl == false {
            
            return 0
        }
        
        return contentCount
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}
