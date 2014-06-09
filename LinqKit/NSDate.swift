//
//  NSDate.swift
//  SwiftLinq
//
//  Created by Demis Bellot on 6/9/14.
//  Copyright (c) 2014 ServiceStack LLC. All rights reserved.
//

import Foundation

extension NSDate {
    
    convenience init(dateString:String, format:String="yyyy-MM-dd") {
        let fmt = NSDateFormatter()
        fmt.timeZone = NSTimeZone.defaultTimeZone()
        fmt.dateFormat = format
        let d = fmt.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d)
    }
    
    convenience init(year:Int, month:Int, day:Int) {
        var c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        let gregorian = NSCalendar(identifier:NSGregorianCalendar)
        var d = gregorian.dateFromComponents(c)
        self.init(timeInterval:0, sinceDate:d)
    }
    
    func components() -> NSDateComponents {
        let compnents  = NSCalendar.currentCalendar().components(
            NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.YearCalendarUnit,
            fromDate: self)
        
        return compnents
    }
    
    // Swift Compiler crashes when extension computed property is used in a call-site. Bug submitted
    //    var year:Int {
    //        return components().year
    //    }
    
    func getYear() -> Int {
        return components().year
    }
    
    func getMonth() -> Int {
        return components().month
    }
    
    func shortDateString() -> String {
        let fmt = NSDateFormatter()
        fmt.timeZone = NSTimeZone.defaultTimeZone()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt.stringFromDate(self)
    }
}

func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedDescending
}
func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedDescending
        || lhs == rhs
}
func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}
func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
        || lhs == rhs
}
func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedSame
}
