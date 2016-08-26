//
//  MocaFlatSpinnerView.swift
//
//  Created by Ky Nguyen on 4/21/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class FlatSpinnerView: UIActivityIndicatorView {
    
    func setPositionCenterView(container: UIView, withColor color: UIColor = UIColor.whiteColor()) {
        
        frame.size = CGSize(width: 32, height: 32)
        frame.origin = CGPoint(x: (container.frame.width - frame.width) / 2, y: (container.frame.height - frame.height) / 2)
        
        self.color = color
        container.addSubview(self)
        startAnimating()
    }
}
