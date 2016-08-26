//
//  UIViewController.swift
//  kLibrary
//
//  Created by Ky Nguyen on 8/27/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit


extension UIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        _ = info[UIImagePickerControllerOriginalImage] as! UIImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func pickImageFromPhotoLibrary() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func enabledView(enabled: Bool) {
        view.userInteractionEnabled = enabled
    }
    
    func createFakeBackButton() -> [UIBarButtonItem] {
        
        let height: CGFloat = 36
        let backView = UIView(frame: CGRectMake(0, 0, 100, height))
        let image = UIImage(named: "back_arrow")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRectMake(0, 0, 36, height)
        backView.addSubview(imageView)
        let content = UILabel()
        content.text = ""
        content.sizeToFit()
        content.frame.size = CGSize(width: content.frame.size.width, height: height)
        content.frame.origin = CGPoint(x: 30, y: 0)
        backView.addSubview(content)
        let button = UIButton(frame: CGRectMake(0, 0, 120, height))
        button.addTarget(self, action: #selector(goBack), forControlEvents: .TouchUpInside)
        backView.addSubview(button)
        
        let barButton = UIBarButtonItem(customView: backView)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        negativeSpacer.width = -20
        
        return [negativeSpacer, barButton]
    }
    
    func addFakeBackButton() {
        guard navigationController?.viewControllers.count >= 2 else { return }
        let buttons = createFakeBackButton()
        navigationItem.leftBarButtonItems = buttons
    }
    
    func goBack() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension UITableViewController {
    
    func animateTable() {
        
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        var index = 0
        for cell in cells {
            UIView.animateWithDuration(1.25, delay: 0.05 * Double(index),
                                       usingSpringWithDamping: 0.65,
                                       initialSpringVelocity: 0.0,
                                       options: UIViewAnimationOptions.CurveEaseInOut,
                                       animations:
                {
                    cell.transform = CGAffineTransformMakeTranslation(0, 0)
                },
                                       completion: nil)
            
            index += 1
        }
    }
}