//
//  MainViewController.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//


import UIKit

class MainViewController: UIViewController, PageViewDelegate {

    private let contentImages = ["nature_pic_1.png",
        "nature_pic_2.png",
        "nature_pic_3.png",
        "nature_pic_4.png"];
    
    let contentText = ["Saigon", "Can Tho", "Ha Noi", "Da Nang"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageController = KPageViewController()
        pageController.delegate = self
        pageController.setupController(contentImages.count)
        
        addChildViewController(pageController)
        self.view.addSubview(pageController.view)
    }
    
    func getPageItemAtIndex(index: Int) -> UIViewController {
        
        let pageItemController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
        pageItemController.itemIndex = index
        pageItemController.imageName = contentImages[index]
        pageItemController.placeName = contentText[index]
        return pageItemController
    }



}

