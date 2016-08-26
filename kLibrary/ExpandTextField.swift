//
//  ExpandTextField.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class ExpandTextField: UITextField {
    
    var nextFriend : UITextField?
    
    func next() { nextFriend?.becomeFirstResponder() }
}
