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
        
        layer.borderColor = color.CGColor
        layer.borderWidth = width
    }
    
    func createRoundCorner(radius: CGFloat) {
        
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func createCircleShape() {
        createRoundCorner(self.frame.size.width / 2)
    }
    
    func createImageFromView() -> UIImage {
        
        UIGraphicsBeginImageContext(bounds.size)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
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

extension UILabel{
    func createSpaceBetweenLines(alignText: NSTextAlignment = NSTextAlignment.Left,spacing: CGFloat = 7) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.maximumLineHeight = 40
        paragraphStyle.alignment = .Left
        
        let ats = [NSParagraphStyleAttributeName:paragraphStyle]
        attributedText = NSAttributedString(string: self.text!, attributes:ats)
        textAlignment = alignText
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

extension UIColor {
    
    /**
     amount greater than 1 is darker, less than 1 is lighter
     */
    func adjustBrightness(amount:CGFloat) -> UIColor {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            brightness += (amount-1.0)
            brightness = max(min(brightness, 1.0), 0.0)
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
        }
        return self
    }
}

extension UITextField {
    
    func setRightViewWithButtonTitle(title: String) -> UIButton {
        
        let button = UIButton()
        button.frame = CGRectMake(0, 0, 50, 100)
        button.titleLabel?.textAlignment = NSTextAlignment.Right
        button.setTitle(title, forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button.titleLabel?.frame = button.bounds
        button.sizeToFit()
        setRightViewWithView(button)
        return button
    }
    
    func setRightViewWithView(view: UIView) {
        
        rightView = view
        rightViewMode = UITextFieldViewMode.Always
        rightView!.contentMode = UIViewContentMode.ScaleAspectFit
        rightView!.clipsToBounds = true
    }
    
    func setRightViewWithButtonImage(image: UIImage) -> UIButton {
        
        let button = UIButton()
        button.frame = CGRectMake(0, 0, 50, 100)
        button.setImage(image, forState: .Normal)
        button.imageView!.contentMode = UIViewContentMode.ScaleAspectFit
        setRightViewWithView(button)
        return button
    }
    
    func setLeftViewWithImage(imge:UIImage){
        
        let imgView = UIImageView(frame: CGRectMake(0, 0, 33,21))
        imgView.image = imge
        imgView.contentMode = .ScaleAspectFill
        leftView = imgView
        leftViewMode = .Always
        leftView!.contentMode = UIViewContentMode.ScaleAspectFit
        leftView!.clipsToBounds = true
    }
    
    func changePlaceholderTextColor(color: UIColor) {
        
        guard let placeholder = placeholder else { return }
        let attributes = [NSForegroundColorAttributeName : color]
        attributedPlaceholder = NSAttributedString(string:placeholder, attributes: attributes)
    }
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIViewController {
    
    func enabledView(enabled: Bool) {
        
        self.view.userInteractionEnabled = enabled
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
        button.addTarget(self, action: #selector(UIViewController.goBack), forControlEvents: UIControlEvents.TouchUpInside)
        backView.addSubview(button)
        
        let barButton = UIBarButtonItem(customView: backView)
        
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        negativeSpacer.width = -20
        
        return [negativeSpacer, barButton]
    }
    
    func addFakeBackButton() {
        
        if self.navigationController?.viewControllers.count < 2 {
            
            let buttons = createFakeBackButton()
            
            self.navigationItem.leftBarButtonItems = buttons
        }
    }
    
    func goBack() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}