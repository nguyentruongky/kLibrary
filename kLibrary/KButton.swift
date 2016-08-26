//
//  KButton
//  kLibrary
//
//  Created by Ky Nguyen on 8/25/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class KButton: UIButton {
    
    let standardHeight: CGFloat = 50
    var savedTitle : String!
    var savedBackgroundColor : UIColor? = UIColor.darkGrayColor()
    
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 50))
        setupControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupControl()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupControl()
    }
    
    func setupControl() {
        backgroundColor = UIColor.darkGrayColor()
        savedBackgroundColor = UIColor.darkGrayColor()
        setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    func changeBackgroundColor(color: UIColor) {
        backgroundColor = color
        savedBackgroundColor = color
    }
    
    func addSpinner() {
        
        let spinner = FlatSpinnerView()
        spinner.setPositionCenterView(self)
        savedTitle = titleLabel?.text
        setTitle("", forState: UIControlState.Normal)
        enabled = false
    }
    
    func removeSpinner() {
        
        enabled = true
        setTitle(savedTitle, forState: UIControlState.Normal)

        for item in subviews {
            if item is FlatSpinnerView {
                item.removeFromSuperview()
                return
            }
        }
    }
    
    override var enabled: Bool {
        
        get {
            return super.enabled
        }
        set(newValue) {
            super.enabled = newValue
            backgroundColor = newValue ? savedBackgroundColor :  UIColor.lightGrayColor().colorWithAlphaComponent(0.5)
        }
    }
}
