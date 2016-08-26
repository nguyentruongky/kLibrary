//
//  UIExtension.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    
    func changeTitleColor(color: UIColor = UIColor.blueColor(), font: UIFont = UIFont.systemFontOfSize(14)) {
        let deleteCardFormat = [
            NSForegroundColorAttributeName: color,
            NSFontAttributeName: font]
        setTitleTextAttributes(deleteCardFormat, forState: .Normal)
    }
}


extension UILabel{
    func createSpaceBetweenLines(alignText: NSTextAlignment = NSTextAlignment.Left, spacing: CGFloat = 7) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.maximumLineHeight = 40
        paragraphStyle.alignment = .Left
        
        let ats = [NSParagraphStyleAttributeName:paragraphStyle]
        attributedText = NSAttributedString(string: self.text!, attributes:ats)
        textAlignment = alignText
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


