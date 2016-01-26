//
//  Utilities.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class Utilities: NSObject {

    static func randomInt(max: UInt32) -> Int {
        
        return Int(arc4random_uniform(max))
    }
    
    static func downloadImage(url: String) -> UIImage {
        
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        return UIImage(data: data!)!
    }
}
