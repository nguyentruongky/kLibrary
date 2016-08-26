//
//  StringExtension.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/25/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//

import UIKit

extension NSAttributedString{
    
    func attributeString(atrString: String, mainStr: String, color: UIColor, font: UIFont){
        let mutableAtrStr = NSMutableAttributedString(string: mainStr)
        let attribute = [NSForegroundColorAttributeName: color, NSFontAttributeName: font]
        let attributeString = NSAttributedString(string: atrString, attributes: attribute)
        mutableAtrStr.appendAttributedString(attributeString)
    }
    
    /**
     format some string in normal string.
     */
    func formatStringInString(string: String,
                              font: UIFont = UIFont.systemFontOfSize(14),
                              color: UIColor = UIColor.blackColor(),
                              boldStrings: [String],
                              boldFont: UIFont = UIFont.boldSystemFontOfSize(14),
                              boldColor: UIColor = UIColor.blueColor()
        ) -> NSAttributedString {
        
        let attributedString =
            NSMutableAttributedString(string: string,
                                      attributes: [
                                        NSFontAttributeName: font,
                                        NSForegroundColorAttributeName: color])
        let boldFontAttribute = [NSFontAttributeName: boldFont, NSForegroundColorAttributeName: boldColor]
        for bold in boldStrings {
            attributedString.addAttributes(boldFontAttribute, range: (string as NSString).rangeOfString(bold))
        }
        return attributedString
    }

    func formatParagraph(string: String, alignText: NSTextAlignment = NSTextAlignment.Left, spacing: CGFloat = 7) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = alignText
        paragraphStyle.maximumLineHeight = 40
        let attributed = [NSParagraphStyleAttributeName:paragraphStyle]
        return NSAttributedString(string: string, attributes:attributed)
    }
}

extension String {
    
    func formatThousandSeparator(separatorCharacter: String = " ") -> String {
        
        guard let numberFromString = Int32(self) else { return self }
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.groupingSeparator = separatorCharacter
        let formattedString = formatter.stringFromNumber(NSNumber(int: numberFromString))
        return formattedString != nil ? formattedString! : self
    }
    
    var length: Int { return characters.count }
    
    func isValidEmail() -> Bool {

        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    
    func trim() -> String {
        return stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func splitString(separator: String) -> [String] {   
        return componentsSeparatedByString(separator)
    }
    
    
}

//
//  SwiftString.swift
//  SwiftString
//
//  Created by Andrew Mayne on 30/01/2016.
//  Copyright © 2016 Red Brick Labs. All rights reserved.
//

public extension String {
    
    ///  Finds the string between two bookend strings if it can be found.
    ///
    ///  - parameter left:  The left bookend
    ///  - parameter right: The right bookend
    ///
    ///  - returns: The string between the two bookends, or nil if the bookends cannot be found, the bookends are the same or appear contiguously.
    func between(left: String, _ right: String) -> String? {
        guard
            let leftRange = rangeOfString(left), rightRange = rangeOfString(right, options: .BackwardsSearch)
            where left != right && leftRange.endIndex != rightRange.startIndex
            else { return nil }
        
        return self[leftRange.endIndex...rightRange.startIndex.predecessor()]
    }
    
    // https://gist.github.com/stevenschobert/540dd33e828461916c11
    func camelize() -> String {
        let source = clean(" ", allOf: "-", "_")
        if source.characters.contains(" ") {
            let first = source.substringToIndex(source.startIndex.advancedBy(1))
            let cammel = NSString(format: "%@", (source as NSString).capitalizedString.stringByReplacingOccurrencesOfString(" ", withString: "", options: [], range: nil)) as String
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = (source as NSString).lowercaseString.substringToIndex(source.startIndex.advancedBy(1))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
        }
    }
    
    func capitalize() -> String {
        return capitalizedString
    }
    
    func contains(substring: String) -> Bool {
        return rangeOfString(substring) != nil
    }
    
    func chompLeft(prefix: String) -> String {
        if let prefixRange = rangeOfString(prefix) {
            if prefixRange.endIndex >= endIndex {
                return self[startIndex..<prefixRange.startIndex]
            } else {
                return self[prefixRange.endIndex..<endIndex]
            }
        }
        return self
    }
    
    func chompRight(suffix: String) -> String {
        if let suffixRange = rangeOfString(suffix, options: .BackwardsSearch) {
            if suffixRange.endIndex >= endIndex {
                return self[startIndex..<suffixRange.startIndex]
            } else {
                return self[suffixRange.endIndex..<endIndex]
            }
        }
        return self
    }
    
    func collapseWhitespace() -> String {
        let components = componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).filter { !$0.isEmpty }
        return components.joinWithSeparator(" ")
    }
    
    func clean(with: String, allOf: String...) -> String {
        var string = self
        for target in allOf {
            string = string.stringByReplacingOccurrencesOfString(target, withString: with)
        }
        return string
    }
    
    func count(substring: String) -> Int {
        return componentsSeparatedByString(substring).count - 1
    }
    
    func endsWith(suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    func ensureLeft(prefix: String) -> String {
        return startsWith(prefix) ? self : "\(prefix)\(self)"
    }
    
    func ensureRight(suffix: String) -> String {
        return endsWith(suffix) ? self : "\(self)\(suffix)"
    }
    
    func indexOf(substring: String) -> Int? {
        
        guard let range = rangeOfString(substring) else { return nil }
        return startIndex.distanceTo(range.startIndex)
    }
    
    func lastIndexOf(target: String) -> Int? {
        guard let range = rangeOfString(target, options: .BackwardsSearch) else { return nil }
        return startIndex.distanceTo(range.startIndex)
    }
    
    func initials() -> String {
        let words = self.componentsSeparatedByString(" ")
        return words.reduce(""){$0 + $1[0...0]}
    }
    
    func initialsFirstAndLast() -> String {
        let words = self.componentsSeparatedByString(" ")
        return words.reduce("") { ($0 == "" ? "" : $0[0...0]) + $1[0...0]}
    }
    
    func isAlpha() -> Bool {
        for chr in characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
    func isAlphaNumeric() -> Bool {
        let alphaNumeric = NSCharacterSet.alphanumericCharacterSet()
        return componentsSeparatedByCharactersInSet(alphaNumeric).joinWithSeparator("").length == 0
    }
    
    func isEmpty() -> Bool {
        let nonWhitespaceSet = NSCharacterSet.whitespaceAndNewlineCharacterSet().invertedSet
        return componentsSeparatedByCharactersInSet(nonWhitespaceSet).joinWithSeparator("").length != 0
    }
    
    func isNumeric() -> Bool {
        return NSNumberFormatter().numberFromString(self) != nil
    }
    
    func join<S : SequenceType>(elements: S) -> String {
        return elements.map{String($0)}.joinWithSeparator(self)
    }
    
    func latinize() -> String {
        return self.stringByFoldingWithOptions(.DiacriticInsensitiveSearch, locale: NSLocale.currentLocale())
    }
    
    func lines() -> [String] {
        return characters.split{$0 == "\n"}.map(String.init)
    }
    
    func pad(n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self, string.times(n)])
    }
    
    func padLeft(n: Int, _ string: String = " ") -> String {
        return "".join([string.times(n), self])
    }
    
    func padRight(n: Int, _ string: String = " ") -> String {
        return "".join([self, string.times(n)])
    }
    
    func slugify() -> String {
        let slugCharacterSet = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-")
        return latinize()
            .lowercaseString
            .componentsSeparatedByCharactersInSet(slugCharacterSet.invertedSet)
            .filter { $0 != "" }
            .joinWithSeparator("-")
    }
    
    func startsWith(prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
    func stripPunctuation() -> String {
        return componentsSeparatedByCharactersInSet(.punctuationCharacterSet())
            .joinWithSeparator("")
            .componentsSeparatedByString(" ")
            .filter { $0 != "" }
            .joinWithSeparator(" ")
    }
    
    func times(n: Int) -> String {
        return (0..<n).reduce("") { $0.0 + self }
    }
    
    func toFloat() -> Float? {
        if let number = NSNumberFormatter().numberFromString(self) {
            return number.floatValue
        }
        return nil
    }
    
    func toInt() -> Int? {
        if let number = NSNumberFormatter().numberFromString(self) {
            return number.integerValue
        }
        return nil
    }
    
    func toDouble(locale: NSLocale = NSLocale.systemLocale()) -> Double? {
        let nf = NSNumberFormatter()
        nf.locale = locale
        if let number = nf.numberFromString(self) {
            return number.doubleValue
        }
        return nil
    }
    
    func toBool() -> Bool? {
        let trimmed = self.trimmed().lowercaseString
        if trimmed == "true" || trimmed == "false" {
            return (trimmed as NSString).boolValue
        }
        return nil
    }
    
    func toDate(format: String = "yyyy-MM-dd") -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.dateFromString(self)
    }
    
    func toDateTime(format : String = "yyyy-MM-dd HH:mm:ss") -> NSDate? {
        return toDate(format)
    }
    
    func trimmedLeft() -> String {
        if let range = rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet().invertedSet) {
            return self[range.startIndex..<endIndex]
        }
        return self
    }
    
    func trimmedRight() -> String {
        if let range = rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet().invertedSet, options: NSStringCompareOptions.BackwardsSearch) {
            return self[startIndex..<range.endIndex]
        }
        return self
    }
    
    func trimmed() -> String {
        return trimmedLeft().trimmedRight()
    }
    
    subscript(r: Range<Int>) -> String {
        get {
            let startIndex = self.startIndex.advancedBy(r.startIndex)
            let endIndex = self.startIndex.advancedBy(r.endIndex - r.startIndex)
            
            return self[startIndex..<endIndex]
        }
    }
    
    func substring(startIndex: Int, length: Int) -> String {
        let start = self.startIndex.advancedBy(startIndex)
        let end = self.startIndex.advancedBy(startIndex + length)
        return self[start..<end]
    }
    
    subscript(i: Int) -> Character {
        get {
            let index = self.startIndex.advancedBy(i)
            return self[index]
        }
    }
    
    static func random(length: Int = 5) -> String {
        
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.startIndex.advancedBy(Int(randomValue))])"
        }
        
        return randomString
    }
}
