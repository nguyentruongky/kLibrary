//
//  DateExtension.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import Foundation

extension NSDate {
    
    func stringFromDate() -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.stringFromDate(self)
    }
    
    convenience init(iso8601String:String) {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.calendar =  NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
        
        var d = dateFormatter.dateFromString(iso8601String)
        
        if d == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        }
        d = dateFormatter.dateFromString(iso8601String)
        
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    func toStringDDMMYYY() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.stringFromDate(self)
        return dateString
    }
    
    func toISO8601String() -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        dateFormatter.calendar =  NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
        
        let result = dateFormatter.stringFromDate(self).stringByAppendingString("Z")
        return result
    }
    
    func getElapsedInterval() -> String {
        
        var interval = NSCalendar.currentCalendar().components(.Year, fromDate: self, toDate: NSDate(), options: []).year
        
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "year".localized :
                "\(interval)" + " " + "years".localized
        }
        
        interval = NSCalendar.currentCalendar().components(.Month, fromDate: self, toDate: NSDate(), options: []).month
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "month".localized :
                "\(interval)" + " " + "months".localized
        }
        
        interval = NSCalendar.currentCalendar().components(.Day, fromDate: self, toDate: NSDate(), options: []).day
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "day".localized :
                "\(interval)" + " " + "days".localized
        }
        
        interval = NSCalendar.currentCalendar().components(.Hour, fromDate: self, toDate: NSDate(), options: []).hour
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "hour".localized :
                "\(interval)" + " " + "hours".localized
        }
        
        interval = NSCalendar.currentCalendar().components(.Minute, fromDate: self, toDate: NSDate(), options: []).minute
        if interval > 0 {
            return interval == 1 ? "\(interval)" + " " + "minute".localized :
                "\(interval)" + " " + "minutes".localized
        }
        
        return "a moment ago"
    }
}