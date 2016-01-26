//
//  FormattedNumber.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

class FormattedNumber: NSObject {

    private static var numberFormatter = NSNumberFormatter()
    
    private static var value: NSNumber?

    static func initWithNumber(number: NSNumber) {
        
        value = number
    }

    private static func initFormatter() {
        
        numberFormatter.locale = NSLocale.currentLocale()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
    }
    
    static func formatNumberWithString(number: String) -> String {
        
        initFormatter()
        
        let intNumber = Int32(number)
        
        if let intNumber = intNumber {
            
            value = NSNumber(int: intNumber)
        }
        
        return formatNumber()
    }
    
    static func formatNumberWithNumber(number: NSNumber) -> String {
        
        initFormatter()
        
        value = number
        
        return formatNumber()
    }
    
    
    private static func formatNumber() -> String {
        
        if let value = value {
            
            return numberFormatter.stringFromNumber(value)!
        }

        return "wrong format number"
    }
}
