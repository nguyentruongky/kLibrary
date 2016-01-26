//
//  StringExtension.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/25/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation

extension String {
    
    mutating func formatThousandSeparator() {
        
        formatThousandSeparator(" ")
    }
    
    mutating func formatThousandSeparator(separatorCharacter: String) {
        
        let numberFromString = Int32(self)
        if let intNumber = numberFromString {
            
            let number = NSNumber(int: intNumber)
            let fmt = NSNumberFormatter()
            fmt.numberStyle = .DecimalStyle
            fmt.groupingSeparator = separatorCharacter
            self = fmt.stringFromNumber(number)!
        }
    }
    
    var length: Int { return self.characters.count }
    
    func isValidEmail() -> Bool {
        
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
        
    }
    
    func trim() -> String {
        
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    var localized: String {
        
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}