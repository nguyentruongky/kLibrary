//
//  UIExtension.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func createBorder(width: CGFloat, color: UIColor) {
        
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = width
    }
    
    func createRoundCorner(radius: CGFloat) {
        
        self.layer.cornerRadius = radius
    }
    
    func createCircleShape() {
        
        createRoundCorner(self.frame.size.width / 2)
    }
}

extension UIImageView {
    
    func blurBackground() {
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.frame
        blurView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.addSubview(blurView)
    }
}

extension UIImage {
    func resize(scale:CGFloat, compressionQuality quality:CGFloat=0.5) -> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData: NSData = UIImageJPEGRepresentation(img, quality)!
        UIGraphicsEndImageContext()
        return UIImage(data: imageData)!
    }
    
    
    func resizeToWidth(width:CGFloat, compressionQuality quality:CGFloat=0.5)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData: NSData = UIImageJPEGRepresentation(img, quality)!
        UIGraphicsEndImageContext()
        return UIImage(data: imageData)!
    }
}

extension UIButton {
    
    func disabledButton() {
        
        self.enabled = false
        self.backgroundColor?.colorWithAlphaComponent(0.5)
    }
    
    func enabledButton() {
        
        self.enabled = true
        self.backgroundColor?.colorWithAlphaComponent(1)
    }
}

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
}

extension UITableViewController {

    func animateTable() {
        
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight = tableView.bounds.size.height
        
        for i in cells {
            
            let cell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            
            let cell = a as UITableViewCell
            UIView.animateWithDuration(1.25, delay: 0.05 * Double(index), usingSpringWithDamping: 0.65, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                cell.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
            
            index++
        }
    }
}
