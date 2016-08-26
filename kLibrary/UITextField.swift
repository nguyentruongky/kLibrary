//
//  UITextField.swift
//  kLibrary
//
//  Created by Ky Nguyen on 8/27/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

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
    
    func showHidePassword() -> String {
        secureTextEntry = !secureTextEntry
        becomeFirstResponder()
        return text!
    }
}
