//
//  UIImage.swift
//  kLibrary
//
//  Created by Ky Nguyen on 8/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func blurBackground() {
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = frame
        blurView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        addSubview(blurView)
    }
    
    func changeImageColor(color: UIColor) {
        guard let image = image else { return }
        self.image = image.changeImageColor()
        tintColor = color
    }
}

extension UIImage {
    func resize(scale: CGFloat, compressionQuality quality: CGFloat = 0.5) -> UIImage {
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData: NSData = UIImageJPEGRepresentation(img, quality)!
        UIGraphicsEndImageContext()
        return UIImage(data: imageData)!
    }
    
    func resize(targetSize: CGSize) -> UIImage {
        
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
    
    func resizeToWidth(width: CGFloat, compressionQuality quality: CGFloat = 0.5) -> UIImage {
        
        let newSize = CGSize(width: width, height: CGFloat(ceil(width / size.width * size.height)))
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData: NSData = UIImageJPEGRepresentation(img, quality)!
        UIGraphicsEndImageContext()
        return UIImage(data: imageData)!
    }
    
    func changeImageColor() -> UIImage {
        guard let image = UIImage(named: "back_arrow") else { return self }
        return image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
    }
    
    func scaleImage(newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let result:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    func createRadius(newSize:CGSize, radius: CGFloat, byRoundingCorners: UIRectCorner?) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        let imgRect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        if let roundingCorners = byRoundingCorners {
            UIBezierPath(roundedRect: imgRect, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: radius, height: radius)).addClip()
        } else {
            UIBezierPath(roundedRect: imgRect, cornerRadius: radius).addClip()
        }
        drawInRect(imgRect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }

}
